package member

import jakarta.servlet.http.HttpServlet
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse

class MemberController1 : HttpServlet() {
    override fun service(req: HttpServletRequest, resp: HttpServletResponse) {
        var method : String? = req.method?:return
        when(method){

        }
    }
}