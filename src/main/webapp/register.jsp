<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Join Us | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
</head>
<body class="bg-[#f8fafc] flex items-center justify-center min-h-screen p-6">
    <div class="w-full max-w-lg">
        <div class="bg-white rounded-[2.5rem] p-10 shadow-2xl shadow-indigo-100 border border-slate-50">
            <div class="mb-10">
                <h2 class="text-3xl font-extrabold text-slate-800 mb-2">Create Account</h2>
                <p class="text-slate-400 font-semibold">Start sharing your knowledge today.</p>
            </div>

            <form action="register" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="md:col-span-2">
                    <label class="block text-[10px] font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Username</label>
                    <input type="text" name="username" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                <div class="md:col-span-2">
                    <label class="block text-[10px] font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Email</label>
                    <input type="email" name="email" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                <div>
                    <label class="block text-[10px] font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Password</label>
                    <input type="password" name="password" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                <div>
                    <label class="block text-[10px] font-black uppercase tracking-widest text-slate-400 mb-2 ml-1">Confirm</label>
                    <input type="password" name="confirm_password" required
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-5 py-4 outline-none transition-all font-semibold">
                </div>
                
                <button type="submit" 
                    class="md:col-span-2 bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-2xl shadow-lg shadow-indigo-200 transition-all mt-4 transform hover:-translate-y-1">
                    Create Account
                </button>
            </form>

            <div class="mt-8 text-center">
                <p class="text-sm text-slate-500 font-semibold">
                    Already have an account? <a href="login.jsp" class="text-indigo-600 hover:underline">Log in here</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>