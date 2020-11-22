演示使用 Swagger 生成 tms-koa（nodejs）框架 API 在文档

在代码中，根据规范（OAS3），编写说明文档。

使用`tms-koa`内置`Swagger`服务生成在线 API 文档。

基于在线文档生成`jmeter`测试计划。

执行`jmeter`测试计划。

输出 markdown 版本的 本地 API 文档。

推荐阅读：[API 的开发、测试与输出文档](https://www.jianshu.com/p/148aa15e43c0)

# 启动 API 服务

## 配置

在`config/app.js`定义了 API 调用认证方法和账户信息，如果需要可以通过新建`config/app.local.js`进行本地化设置，具体设置参见`tms-koa`项目。

通过新建`config/swagger.local.js`进行本地化设置，具体设置参见`tms-koa`项目。

如果没有在配置文件中指定规范版本，`tms-koa`框架支持通过环境变量`TMS_KOA_OAS_VERSION`指定`openapi`规范的版本。

生成文件`docker-compose.override.yml`进行本地设置。

## 运行

> docker-compose up back

> docker-compose down

# 生成测试计划

执行命令`gen-testplan.sh`，将生成的测试计划输出到`jmeter`目录下。

每个标签会生成一个测试计划。

# 执行测试计划

执行命令`run-testplan.sh`，将测试报告输出到`jmeter/report`目录下。

每个测试计划的报告在以测试计划名命名的子目录中。

# 生成 API 说明文档（markdown）

执行命令`gen-markdown.sh`，将 Markdown 格式的文档输出到`docs`目录下。
