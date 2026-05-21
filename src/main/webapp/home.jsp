<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>CheatSheet | Master Your Syntax</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; }
        .glass { background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.4); }
    </style>
</head>
<body>
    
    <nav class="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-[90%] glass rounded-2xl px-8 py-4 flex items-center justify-between shadow-xl shadow-indigo-100/50">
        <a href="home" class="text-2xl font-black bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">CheatSheet.</a>
        <div class="flex items-center gap-4">
            <c:choose>
                <c:when test="${not empty userObj}">
                    <span class="text-sm font-bold text-slate-700">Hi, @${userObj.username}</span>
                    <a href="${userObj.role == 'ADMIN' ? 'admin-dash' : 'user-dash'}" class="text-sm font-bold text-indigo-600 hover:underline">Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="login" class="text-sm font-bold text-slate-600 hover:text-indigo-600 transition-colors">Login</a>
                    <a href="register" class="bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2.5 rounded-xl text-sm font-bold shadow-lg shadow-indigo-200 transition-all">Get Started</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <main class="pt-36 pb-20 px-6">
        
        <div class="max-w-4xl mx-auto text-center mb-10">
            <h1 class="text-5xl md:text-6xl font-extrabold text-slate-900 mb-6 leading-tight">
                Don't memorize. <br><span class="text-indigo-600">Just Cheat.</span>
            </h1>
            <p class="text-base text-slate-500 mb-8 max-w-2xl mx-auto">
                The ultimate collection of developer cheat sheets, syntax snippets, and coding shortcuts. Shared by the community, for the community.
            </p>
            
            <form action="home" method="GET" class="relative max-w-xl mx-auto group">
                <c:if test="${not empty activeCatId}">
                    <input type="hidden" name="catId" value="${activeCatId}">
                </c:if>
                <input type="text" name="query" value="${searchedQuery}" placeholder="Search for 'Git', 'CSS Grid', 'Java'..." 
                    class="w-full h-14 bg-white rounded-2xl px-14 shadow-xl shadow-indigo-100/40 outline-none border-2 border-transparent focus:border-indigo-200 transition-all text-base">
                <i class="fa-solid fa-magnifying-glass absolute left-5 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-indigo-600 text-lg transition-colors"></i>
                <c:if test="${not empty searchedQuery}">
                    <a href="home?catId=${activeCatId}" class="absolute right-5 top-1/2 -translate-y-1/2 text-xs font-bold text-rose-500 hover:underline">Clear</a>
                </c:if>
            </form>
        </div>

        <div class="max-w-5xl mx-auto mb-14">
            <div class="flex flex-wrap justify-center gap-2.5">
                <a href="home?query=${searchedQuery}" 
                   class="px-5 py-2 rounded-xl text-xs font-bold border transition-all ${empty activeCatId ? 'bg-indigo-600 border-indigo-600 text-white shadow-md' : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'}">
                    All Badges
                </a>
                <c:forEach var="cat" items="${categoryList}">
                    <a href="home?catId=${cat.id}&query=${searchedQuery}" 
                       class="px-5 py-2 rounded-xl text-xs font-bold border transition-all ${activeCatId == cat.id ? 'bg-indigo-600 border-indigo-600 text-white shadow-md' : 'bg-white border-slate-200 text-slate-600 hover:bg-slate-50'}">
                        ${cat.name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8">
            <c:choose>
                <c:when test="${empty publicCheats}">
                    <div class="col-span-1 md:col-span-3 text-center py-16 bg-white rounded-3xl border border-dashed border-slate-200">
                        <i class="fa-solid fa-code-cross text-4xl text-slate-200 block mb-3"></i>
                        <h4 class="text-base font-bold text-slate-700">No Cheat Sheets Match Your Search</h4>
                        <p class="text-xs text-slate-400 mt-1">Try utilizing different keywords or select another syntax folder category.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="cheat" items="${publicCheats}">
                        <div class="bg-white p-7 rounded-[2.5rem] border border-slate-100 shadow-sm flex flex-col justify-between hover:shadow-xl hover:shadow-indigo-50/50 transition-all group duration-300">
                            <div class="space-y-4">
                                <div class="flex items-center justify-between">
                                    <span class="bg-indigo-50 text-indigo-600 font-black px-3 py-1 rounded-lg text-[10px] uppercase">${cheat.categoryName}</span>
                                    <span class="text-[11px] font-bold text-slate-400">@${cheat.userName}</span>
                                </div>
                                
                                <h3 class="text-xl font-extrabold text-slate-800 leading-snug group-hover:text-indigo-600 transition-colors">${cheat.title}</h3>
                                <p class="text-xs text-slate-500 leading-relaxed line-clamp-3 font-medium">${cheat.content}</p>
                            </div>
                            
                            <div class="pt-6 mt-6 border-t border-slate-50 flex flex-col gap-3">
                                <div class="flex justify-between text-[10px] text-slate-400 font-semibold">
                                    <span><i class="fa-regular fa-calendar mr-1"></i>${cheat.createdAt}</span>
                                    <span><i class="fa-regular fa-pen-to-square mr-1"></i>${cheat.updatedAt}</span>
                                </div>
                                <a href="view-cheat?id=${cheat.id}" class="w-full mt-1 text-center bg-slate-50 hover:bg-indigo-600 text-slate-700 hover:text-white py-3 rounded-2xl text-xs font-black transition-all border border-slate-100 hover:border-indigo-600 shadow-sm">
                                    View Cheat Sheet
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
    </main>
</body>
</html>