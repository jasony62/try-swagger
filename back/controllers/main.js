const { Ctrl, ResultData } = require('tms-koa')

/**
 * 控制器类，提供API
 * @extends Ctrl
 */
class Main extends Ctrl {
  /**
   * 返回跳过认证的方法名数组
   */
  static tmsAccessWhite() {
    return ['tryGet', 'tryPost']
  }
  /**
   * @swagger
   *
   *  /tryGet:
   *    get:
   *      tags:
   *        - test1
   *        - class2
   *      description: 测试get方法，传入参数，并返回结果
   *      parameters:
   *        - name: value
   *          description: 传入1个值
   *          in: query
   *          required: false
   *          schema:
   *            type: string
   *      responses:
   *        '200':
   *          description: 将输入的值作为执行结果返回
   *          content:
   *            application/json:
   *              schema:
   *                "$ref": "#/components/schemas/ResponseData"
   */
  tryGet() {
    let { value } = this.request.query
    const { bucket } = this
    console.log('tryGet', value)
    return new ResultData(`收到：${value}`)
  }
  /**
   * @swagger
   *
   *  /tryPost:
   *    post:
   *      tags:
   *        - test1
   *        - class2
   *      description: 测试post方法，传入参数，并返回结果
   *      requestBody:
   *        content:
   *          application/json:
   *            schema:
   *              type: object
   *        required: true
   *      responses:
   *        '200':
   *          description: 将输入的值作为执行结果返回
   *          content:
   *            application/json:
   *              schema:
   *                "$ref": "#/components/schemas/ResponseData"
   *
   */
  tryPost() {
    let posted = this.request.body
    console.log('tryPost', posted)
    return new ResultData(posted)
  }
  /**
   * @swagger
   *
   * /tryAuthByQuery:
   *   get:
   *     tags:
   *       - test2
   *       - class1
   *     description: 测试通过查询参数传递认真token
   *     security:
   *       - QueryTokenAuth: []
   *     responses:
   *       '200':
   *         description: 正常调用
   *
   */
  tryAuthByQuery() {
    console.log('tryAuthByQuery')
    return new ResultData('ok')
  }
  /**
   * @swagger
   *
   * /tryAuthByHeader:
   *   get:
   *     tags:
   *       - test2
   *       - class1
   *     description: 测试通过请求头传递认真token
   *     security:
   *       - HeaderTokenAuth: []
   *     responses:
   *       '200':
   *         description: 正常调用
   *
   */
  tryAuthByHeader() {
    console.log('tryAuthByHeader')
    return new ResultData('ok')
  }
}
module.exports = Main
