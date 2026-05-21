<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Security Check: Admin မဟုတ်ရင် ပြန်မောင်းထုတ်မယ် --%>
<c:if test="${empty userObj || userObj.role != 'ADMIN'}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; }
        .sidebar-link:hover, .sidebar-link.active {
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            color: #4f46e5;
        }
    </style>
</head>
<body class="flex min-h-screen">

    <aside class="w-72 bg-slate-50 border-r border-slate-200 p-6 flex flex-col fixed h-full">
        <div class="mb-12 px-2">
            <h1 class="text-2xl font-black bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">CheatSheet.</h1>
            <p class="text-[10px] font-bold text-slate-400 uppercase tracking-[2px] mt-1">Admin Central</p>
        </div>

        <nav class="space-y-2 flex-1">
            <a href="admin-dash" class="sidebar-link active flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-bold transition-all">
                <i class="fa-solid fa-chart-pie text-lg"></i> Overview
            </a>
            <a href="manage-cheats" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-code-pull-request text-lg"></i> Manage Cheats
            </a>
            <a href="manage-categories" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-tags text-lg"></i> Categories
            </a>
            <a href="manage-users" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-users-gear text-lg"></i> User Control
            </a>
        </nav>

        <div class="mt-auto p-4 bg-indigo-50 rounded-[2rem] border border-indigo-100">
            <div class="flex items-center gap-3 mb-3">
                <div class="w-10 h-10 rounded-full bg-indigo-600 flex items-center justify-center text-white text-xs font-bold">AD</div>
                <div>
                    <p class="text-xs font-bold text-slate-900">${userObj.username}</p>
                    <p class="text-[10px] text-indigo-500 font-bold uppercase">Super Admin</p>
                </div>
            </div>
            <a href="logout" class="block text-center bg-white text-red-500 text-xs font-bold py-2 rounded-xl border border-red-50 hover:bg-red-50 transition-colors">Logout</a>
        </div>
    </aside>

    <main class="ml-72 flex-1 p-10">
        
        <header class="flex justify-between items-center mb-10">
            <div>
                <h2 class="text-3xl font-extrabold text-slate-900">Dashboard Overview</h2>
                <p class="text-slate-500 text-sm">Welcome back. Control the content quality today.</p>
            </div>
            <div class="flex gap-4">
                <button class="bg-white p-3 rounded-xl border border-slate-200 shadow-sm hover:bg-slate-50 transition-all text-slate-600">
                    <i class="fa-regular fa-bell text-lg"></i>
                </button>
            </div>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-10">
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm">
                <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center mb-4"><i class="fa-solid fa-file-code text-xl"></i></div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider">Total Cheats</p>
                <h3 class="text-2xl font-black text-slate-900">${not empty totalCheats ? totalCheats : 0}</h3>
            </div>
            
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm">
                <div class="w-12 h-12 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center mb-4"><i class="fa-solid fa-users text-xl"></i></div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider">Active Users</p>
                <h3 class="text-2xl font-black text-slate-900">${not empty activeUsers ? activeUsers : 0}</h3>
            </div>
            
            
            
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm">
                <div class="w-12 h-12 bg-rose-50 text-rose-600 rounded-2xl flex items-center justify-center mb-4"><i class="fa-solid fa-ban text-xl"></i></div>
                <p class="text-slate-400 text-xs font-bold uppercase tracking-wider">Banned Cheats</p>
                <h3 class="text-2xl font-black text-slate-900">${not empty bannedCheats ? bannedCheats : 0}</h3>
            </div>
        </div>

        <div class="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden">
            <div class="p-8 border-b border-slate-50 flex justify-between items-center">
                <h3 class="text-xl font-black text-slate-800">Recent Cheat Sheets</h3>
                <div class="flex gap-2">
                    <a href="manage-cheats" class="text-xs font-bold px-4 py-2 rounded-lg bg-indigo-50 text-indigo-600 transition-all hover:bg-indigo-100">View All Workspace</a>
                </div>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Cheat Info</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Category</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Status</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-50">
                        <c:choose>
                            <c:when test="${empty cheatList}">
                                <tr>
                                    <td colspan="4" class="p-16 text-center text-slate-400 font-bold text-xs">
                                        <i class="fa-solid fa-code text-3xl block mb-2 text-slate-200"></i> No recent cheat sheets found.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="cheat" items="${cheatList}">
                                    <tr class="hover:bg-slate-50/50 transition-colors">
                                        <td class="px-8 py-5">
                                            <div class="flex items-center gap-4">
                                                <div class="w-10 h-10 rounded-xl bg-slate-100 flex items-center justify-center text-slate-400">
                                                    <i class="fa-solid fa-code text-sm text-indigo-500"></i>
                                                </div>
                                                <div>
                                                    <p class="text-sm font-bold text-slate-800">${cheat.title}</p>
                                                    <p class="text-[11px] text-slate-400">By @${cheat.userName}</p>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td class="px-8 py-5">
                                            <span class="bg-indigo-50 text-indigo-600 text-[10px] font-black px-3 py-1 rounded-full uppercase tracking-wider">
                                                ${cheat.categoryName}
                                            </span>
                                        </td>
                                        
                                        <td class="px-8 py-5">
                                            <c:choose>
                                                <c:when test="${cheat.status == 'APPROVED'}">
                                                    <span class="flex items-center gap-1.5 text-emerald-500 text-[11px] font-bold">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Approved
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="flex items-center gap-1.5 text-rose-500 text-[11px] font-bold">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-rose-500"></span> Banned
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td class="px-8 py-5 text-right space-x-1">
                                            <c:choose>
                                                <c:when test="${cheat.status == 'APPROVED'}">
                                                    <a href="admin-dash?action=ban&id=${cheat.id}" 
                                                       onclick="return confirm('Are you sure you want to BAN this snippet?')"
                                                       class="inline-flex items-center justify-center w-9 h-9 rounded-xl bg-rose-50 text-rose-500 hover:bg-rose-500 hover:text-white transition-all"
                                                       title="Ban Snippet">
                                                        <i class="fa-solid fa-ban text-xs"></i>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center justify-center w-9 h-9 rounded-xl bg-slate-50 text-slate-300 border border-slate-100 cursor-not-allowed">
                                                        <i class="fa-solid fa-ban text-xs"></i>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </main>

</body>
</html>