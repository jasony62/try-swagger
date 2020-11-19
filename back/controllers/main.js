const { Ctrl, ResultData } = require('tms-koa')

class Main extends Ctrl {
  /**
   * @swagger
   *
   *  /tryGet:
   *    get:
   *      tags:
   *        - test1
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
   *        - test2
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
}
module.exports = Main
