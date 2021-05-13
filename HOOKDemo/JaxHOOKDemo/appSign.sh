# 0 ----- 准备
ASSETS_PATH="${SRCROOT}/APP"

# 1 ----- 拿到APP的路径
# 拿到临时APP的路径
TEMP_APP_PATH=$(set -- "${ASSETS_PATH}/"*.app;echo "$1")
# 打印临时APP的路径
echo "TEMP_APP_PATH路径:$TEMP_APP_PATH"

# 2 ----- 将.app拷贝进工程下
# TARGET_NAME --- target名称
# BUILT_PRODUCTS_DIR 工程生成的APP包的路径
TARGET_APP_PATH="$BUILT_PRODUCTS_DIR/$TARGET_NAME.app"
# 打印工程生成的APP包的路径
echo "自己的app的路径:$TARGET_APP_PATH"

# 清空路径下的文件夹
rm -rf $TARGET_APP_PATH
# 创建文件夹
mkdir -p $TARGET_APP_PATH
# 将 TEMP_APP_PATH 拷贝到 TARGET_APP_PATH
cp -rf $TEMP_APP_PATH/ $TARGET_APP_PATH

# 3 ----- 删除 extension 和 watchAPP，个人证书无法签名 extension
rm -rf "$TARGET_APP_PATH/PlugIns"
rm -rf "$TARGET_APP_PATH/Watch"

# 4 ----- 更新info.plist文件 CFBundleIdentifier
# 设置 "Set : KEY Value" "目标文件路径"
/usr/libexec/PlistBuddy -c "Set : CFBundleIdentifier $PRODUCT_BUNDLE_IDENTIFIER" "$TARGET_APP_PATH/Info.plist"

# 5 ----- 给MachO文件上执行权限
APP_BINARY=`plutil -convert xml1 -o $TARGET_APP_PATH/Info.plist|grep -A1 Exec|tail -n1|cut -f2 -d\>|cut -f1 -d\<`
# 上可执行权限
chmod +x "$TARGET_APP_PATH/$APP_BINARY"

# 6 ----- 重签名第三方 Frameworks
TARGET_APP_FRAMEWORKS_PATH="$TARGET_APP_PATH/Frameworks"
if [ -d "$TARGET_APP_FRAMEWORKS_PATH" ];
then
for FRAMEWORK in "$TARGET_APP_FRAMEWORKS_PATH/"*
do

#签名
/usr/bin/codesign --force --sign "$EXPANDED_CODE_SIGN_IDENTITY" "$FRAMEWORK"
done
fi

# 7 ----- 注入 (注意，在重签名APP之前，先注释下面的代码，等到重签名完成之后，再去注入代码)
./yololib "$TARGET_APP_PATH/$APP_BINARY" "Frameworks/JaxHOOK.framework/JaxHOOK"
