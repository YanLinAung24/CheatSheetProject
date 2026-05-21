<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${cheat.title} | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; }
        .glass { background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.4); }
    </style>
</head>
<body class="bg-slate-50 min-h-screen pb-20">

    <nav class="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-[90%] glass rounded-2xl px-8 py-4 flex items-center justify-between shadow-xl shadow-indigo-100/50">
        <a href="home" class="text-2xl font-black bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">CheatSheet.</a>
        <div class="flex items-center gap-4">
            <c:choose>
                <c:when test="${not empty userObj}">
                    <span class="text-sm font-bold text-slate-700">Hi, @${userObj.username}</span>
                    <a href="${userObj.role == 'ADMIN' ? 'admin-dash' : 'user-dash'}" class="text-sm font-bold text-indigo-600 hover:underline">Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="text-sm font-bold text-slate-600 hover:text-indigo-600 transition-colors">Login</a>
                    <a href="register.jsp" class="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2.5 rounded-xl text-sm font-bold shadow-lg shadow-indigo-200 transition-all">Get Started</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="max-w-4xl mx-auto px-6 pt-32 space-y-6">
        
        <a href="home" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-indigo-600 transition-colors bg-white px-4 py-2 rounded-xl border border-slate-100 shadow-sm">
            <i class="fa-solid fa-arrow-left-long"></i> Back to Explorer
        </a>

        <article class="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden p-8 md:p-12 space-y-6">
            <div class="flex flex-wrap items-center justify-between gap-4 border-b border-slate-100 pb-6">
                <div class="flex items-center gap-3">
                    <span class="bg-indigo-600 text-white font-black px-3.5 py-1.5 rounded-xl text-[10px] uppercase tracking-wider">${cheat.categoryName}</span>
                    <span class="text-sm font-bold text-slate-700">Contributor: <strong class="text-indigo-600">@${cheat.userName}</strong></span>
                </div>
                <div class="flex gap-4 text-xs font-medium text-slate-400">
                    <p><i class="fa-regular fa-clock mr-1.5"></i>Posted: ${cheat.createdAt}</p>
                    <p><i class="fa-regular fa-pen-to-square mr-1.5"></i>Updated: ${cheat.updatedAt}</p>
                </div>
            </div>

            <h1 class="text-3xl md:text-4xl font-black text-slate-900 leading-tight">${cheat.title}</h1>

            <div class="relative group">
                <button onclick="copyToClipboard()" class="absolute right-4 top-4 bg-slate-800 text-slate-300 hover:text-white px-3 py-1.5 rounded-lg text-[10px] font-bold border border-slate-700 transition-all flex items-center gap-1.5">
                    <i class="fa-regular fa-copy"></i> <span id="copyText">Copy Code</span>
                </button>
                <pre id="codeBlock" class="bg-slate-900 rounded-3xl p-8 pt-14 text-slate-200 text-sm font-mono shadow-inner overflow-x-auto whitespace-pre-wrap leading-relaxed"><c:out value="${cheat.content}"/></pre>
            </div>
        </article>
    </div>

    <script>
        function copyToClipboard() {
            const code = document.getElementById("codeBlock").innerText;
            navigator.clipboard.writeText(code).then(() => {
                const btnText = document.getElementById("copyText");
                btnText.innerText = "Copied!";
                setTimeout(() => { btnText.innerText = "Copy Code"; }, 2000);
            });
        }
    </script>
</body>
</html>