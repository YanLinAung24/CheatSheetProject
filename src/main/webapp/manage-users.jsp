<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Security Check --%>
<c:if test="${empty userObj || userObj.role != 'ADMIN'}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Control | CheatSheet</title>
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
            <a href="admin-dash" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-chart-pie text-lg"></i> Overview
            </a>
            <a href="manage-cheats" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-code-pull-request text-lg"></i> Manage Cheats
            </a>
            <a href="manage-categories" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-tags text-lg"></i> Categories
            </a>
            <a href="manage-users" class="sidebar-link active flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-bold transition-all">
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

    <main class="ml-72 flex-1 p-10 space-y-8">
        
        <header class="flex justify-between items-center">
            <div>
                <h2 class="text-3xl font-extrabold text-slate-900">User Control Center</h2>
                <p class="text-slate-500 text-sm">Monitor registered members, review registration timeframes and terminate access.</p>
            </div>
        </header>

        <div class="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden">
            <div class="p-6 border-b border-slate-50 flex justify-between items-center bg-slate-50/50">
                <h3 class="text-base font-black text-slate-800">Standard Users Directory</h3>
                <span class="bg-indigo-50 text-indigo-600 text-[10px] font-black px-3 py-1 rounded-full uppercase tracking-wider">Active Members: ${userList.size()}</span>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-50">
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">User Identity</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Email Address</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Account Type</th>
                            <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Joined Date & Time (AM/PM)</th>
                           	<th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-50">
                        <c:choose>
                            <c:when test="${empty userList}">
                                <tr>
                                    <td colspan="5" class="p-16 text-center text-slate-400 font-bold text-xs">
                                        <i class="fa-solid fa-users-slash text-3xl block mb-2 text-slate-200"></i> No standard users registered yet.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="user" items="${userList}">
                                    <tr class="hover:bg-slate-50/50 transition-colors">
                                        <td class="px-8 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-indigo-50 to-purple-50 text-indigo-500 flex items-center justify-center font-bold text-xs uppercase">
                                                    ${user.username.substring(0,2)}
                                                </div>
                                                <div>
                                                    <p class="text-sm font-bold text-slate-800">${user.username}</p>
                                                  
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td class="px-8 py-4 text-xs font-semibold text-slate-600">
                                            ${user.email}
                                        </td>
                                        
                                        <td class="px-8 py-4">
                                            <span class="bg-slate-100 text-slate-600 text-[9px] font-black px-2.5 py-1 rounded-md uppercase tracking-wider">
                                                ${user.role}
                                            </span>
                                        </td>
                                        
                                        <td class="px-8 py-4 text-xs font-bold text-slate-500">
                                            <i class="fa-regular fa-clock text-slate-400 mr-1"></i> ${user.createdAt}
                                        </td>
                                        <td class="px-8 py-4 text-right">
                                            <a href="manage-users?action=delete&id=${user.id}" 
                                               onclick="return confirm('Are you absolutely sure you want to DELETE this user account? All their created data might be affected.')"
                                               class="inline-flex items-center justify-center w-9 h-9 rounded-xl bg-rose-50 text-rose-500 hover:bg-rose-600 hover:text-white transition-all shadow-sm border border-rose-100/50"
                                               title="Delete User Account">
                                                <i class="fa-solid fa-trash-can text-xs"></i>
                                            </a>
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