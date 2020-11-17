演示使用 Swagger 生成 tms-koa（nodejs）框架 API 在文档

# 运行

> docker-compose up

> docker-compose down

# 配置

通过新建`config\swagger.local.js`进行本地化设置。

如果没有在配置文件中指定规范版本，`tms-koa`框架支持通过环境变量`TMS_KOA_OAS_VERSION`指定`openapi`规范的版本。

生成文件`docker-compose.override.yml`进行本地设置。
