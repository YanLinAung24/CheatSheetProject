<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#f8fafc] flex items-center justify-center min-h-screen p-6">
    <div class="w-full max-w-md">
        <div class="text-center mb-10">
            <h1 class="text-3xl font-black bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent mb-2">CheatSheet.</h1>
            <p class="text-slate-400 text-sm font-semibold">Welcome back, dev!</p>
        </div>

        <div class="bg-white rounded-[2.5rem] p-10 shadow-2xl shadow-indigo-100 border border-slate-50">
            <h2 class="text-2xl font-extrabold text-slate-800 mb-8">Sign In</h2>

            <c:if test="${not empty errorMsg}">
                <div class="bg-red-50 text-red-500 p-4 rounded-xl text-sm font-bold mb-6 flex items-center gap-3">
                    <i class="fa-solid fa-circle-exclamation"></i> ${errorMsg}
                </div>
            </c:if>

            <form action="login" method="post" class="space-y-6">
                <div>
                    <label class="block text-xs font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Email Address</label>
                    <input type="email" name="email" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                <div>
                    <label class="block text-xs font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Password</label>
                    <input type="password" name="password" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                <button type="submit" 
                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-2xl shadow-lg shadow-indigo-200 transition-all transform hover:-translate-y-1">
                    Login Now
                </button>
            </form>

            <div class="mt-8 text-center">
                <p class="text-sm text-slate-500 font-semibold">
                    You don't have account? <a href="register.jsp" class="text-indigo-600 hover:underline">Register Now</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>