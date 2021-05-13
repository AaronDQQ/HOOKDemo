# HOOKDemo
① ：创建 `HOOK工程` & `带注入的代码（JaxHOOK）`，并运行。目的是让手机认证描述文件。
② ：创建 `测试APP`。
③ ：在`HOOK工程`的目录下，创建`APP`文件夹；将`yololib`可以执行文件拖入工程目录下；创建`appSign.sh`脚本文件。
④ ：将`DobbyX.framework`，引入工程，并撰写`HOOK`代码，此时先注释掉`HOOK`代码。
⑤ ：在`TARGETS -> JaxHOOKDemo -> Buid Phases`中配置脚本信息；运行工程，对APP进行重签名。
⑥ ：打开注入命令，打开`HOOK`代码；运行工程，进行`HOOK`。
