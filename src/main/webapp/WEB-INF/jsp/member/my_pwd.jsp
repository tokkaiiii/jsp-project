<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
      html, body {
        height: 100vh;
        margin: 0;
        display: flex;
        justify-content: center;
      }
      main{
        width: 500px;
        height: 100vh;
        border: 1px solid #000;
        box-sizing: border-box;
      }
      form {
        display: flex;
        flex-direction: column;
        justify-content: center;
        border: 5px solid #000;
        width: 500px;
        height: 100vh;
        align-self:center;
      }
      select{
        border: #dddddd 1px solid;
      }

      .login {
        cursor: pointer;
        width: 16.3rem;
        height: 3rem;
        border: none;
        border-radius: 20px;
      }

      .hide {
        display: none;
        overflow: hidden;
      }

      .password {
        position: relative;
      }

      .password .eyes {
        position: absolute;
        top: 0;
        bottom: 0;
        right: 0;
        margin: auto 2px;
        height: 30px;
        font-size: 22px;
        cursor: pointer;
      }

      button {
        margin-right: 5px;

      }
      .need-top{
        margin-top: 16px;
      }
      fieldset{
        margin-top: 16px;
        display: flex;
        justify-content: center;
      }
    </style>
</head>
<body>
<main>
    <form action="/member/member.do?method=myPwd" method="post">
        <div class="form-floating input-group mb-3">
            <input type="text" class="form-control" id="authenticCode" name="authenticCode" placeholder="인증번호"/>
            <label for="authenticCode">인증번호</label>
            <button class="btn btn-outline-secondary" type="button" id="authConfirmBtn">인증하기</button>
        </div>
        <div class="msg input-authCode text-success hide">인증이 완료되었습니다</div>
        <div class="msg fail-authCode text-danger hide">인증 코드가 맞지않습니다. 다시 입력해주세요</div>
        <div class="form-floating password">
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호"/>
            <div class="eyes"><i class="fa-regular fa-eye"></i></div>
            <label for="password">비밀번호</label>
        </div>
        <div class="msg fail-password-msg text-danger hide">
            8글자 이상, 영문 대소문자 숫자, 특수문자(@$!%*#?&)를 포함해주세요
        </div>
        <div class="msg input-password text-danger hide">비밀번호를 입력해주세요</div>
        <div class="form-floating">
            <input type="password" class="form-control need-top" id="password-retype" name="password-retype" placeholder="비밀번호 확인"/>
            <label for="password-retype">비밀번호 확인</label>
        </div>
        <div class="msg miss-pwd text-danger hide">비밀번호가 일치하지 않습니다</div>
        <div class="msg input-password-retype text-danger hide">
            비밀번호 확인을 입력해주세요
        </div>
        <fieldset class="join">
            <button type="button" class="btn btn-dark" id="join">비밀번호 변경</button>
            <button type="button" class="btn btn-outline-dark" id="cancel">취소</button>
        </fieldset>
    </form>
    <script>
      const authenticCode = document.getElementById('authenticCode');
      document.getElementById('authConfirmBtn').addEventListener('click',()=>{
        if(authenticCode.value === "${code}"){
          document.querySelector('.input-authCode').classList.remove('hide');
          document.querySelector('.fail-authCode').classList.add('hide');
          document.getElementById('authenticCode').classList.remove('is-invalid')
          document.getElementById('authenticCode').classList.add('is-valid')
        }else {
          document.getElementById('authenticCode').classList.remove('is-valid')
          document.querySelector('.input-authCode').classList.add('hide');
          document.querySelector('.fail-authCode').classList.remove('hide');
          document.getElementById('authenticCode').classList.add('is-invalid')
        }
      })

      function validatePassword(password) {
        const pattern =
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
        return pattern.test(password);
      }

      const checkPassword = () => {
        const failPasswordMsg = document.querySelector('.fail-password-msg');
        const inputPasswordMsg = document.querySelector('.input-password');
        if (validatePassword(password.value)) {
          failPasswordMsg.classList.add('hide');
          inputPasswordMsg.classList.add('hide');
          password.classList.remove('is-invalid');
          password.classList.add('is-valid');
        } else if (password.value === '') {
          password.classList.remove('is-valid');
          failPasswordMsg.classList.add('hide');
          inputPasswordMsg.classList.remove('hide');
          password.classList.add('is-invalid');
        } else {
          password.classList.remove('is-valid');
          failPasswordMsg.classList.remove('hide');
          inputPasswordMsg.classList.add('hide');
          password.classList.add('is-invalid');
        }
        checkFormValidity();
      };
      const password = document.getElementById('password');
      const passwordRetype = document.getElementById('password-retype');

      function validatePasswordRetype(password, passwordRetype) {
        return password === passwordRetype;
      }

      const checkPasswordRetype = () => {
        const failRetypePasswordMsg = document.querySelector('.miss-pwd');
        const inputPasswordRetypeMsg = document.querySelector(
            '.input-password-retype'
        );
        if (validatePasswordRetype(password.value, passwordRetype.value)) {
          failRetypePasswordMsg.classList.add('hide');
          inputPasswordRetypeMsg.classList.add('hide');
          passwordRetype.classList.remove('is-invalid')
          passwordRetype.classList.add('is-valid')
        } else if (passwordRetype.value === '') {
          passwordRetype.classList.remove('is-valid')
          failRetypePasswordMsg.classList.add('hide');
          inputPasswordRetypeMsg.classList.remove('hide');
          passwordRetype.classList.add('is-invalid')
        } else {
          passwordRetype.classList.remove('is-valid')
          failRetypePasswordMsg.classList.remove('hide');
          inputPasswordRetypeMsg.classList.add('hide');
          passwordRetype.classList.add('is-invalid')
        }
        checkFormValidity();
      };
      password.addEventListener('keyup', checkPassword);
      passwordRetype.addEventListener('keyup', checkPasswordRetype);
      $(function () {
        $('.eyes').on('click', function () {

          $('.password').toggleClass('active');

          if ($('.password').hasClass('active') === true) {
            $(this).find('.fa-eye').attr('class', "fa-regular fa-eye-slash").parents('.password').find(
                '#password').attr('type', 'text');
          } else {
            $(this).find('.fa-eye-slash').attr('class', "fa-regular fa-eye").parents('.password').find(
                '#password').attr('type', 'password');
          }
        });
      });

    </script>
</main>

</body>
</html>
