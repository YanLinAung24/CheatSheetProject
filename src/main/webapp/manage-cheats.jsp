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
    <title>Manage Cheats | CheatSheet</title>
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
            <a href="manage-cheats" class="sidebar-link active flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-bold transition-all">
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

    <main class="ml-72 flex-1 p-10 grid grid-cols-1 xl:grid-cols-4 gap-8">
        
        <div class="xl:col-span-1 space-y-4">
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-sm sticky top-10">
                <h3 class="text-xs font-black text-slate-400 uppercase tracking-wider mb-4"><i class="fa-solid fa-folder-tree mr-1 text-indigo-500"></i> Select Category</h3>
                <div class="space-y-1.5 max-h-[500px] overflow-y-auto pr-1">
                    <c:forEach var="cat" items="${categoryList}">
                        <a href="manage-cheats?catId=${cat.id}" 
                           class="w-full flex items-center justify-between p-3.5 rounded-xl text-xs font-bold transition-all border ${selectedCatId == cat.id ? 'bg-indigo-600 text-white border-indigo-600 shadow-md shadow-indigo-600/10' : 'bg-slate-50 text-slate-700 border-slate-100 hover:bg-slate-100'}">
                            <span class="truncate pr-2">${cat.name}</span>
                            <i class="fa-solid fa-chevron-right text-[10px] opacity-60"></i>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="xl:col-span-3 space-y-6">
            <header class="flex justify-between items-center mb-4">
                <div>
                    <h2 class="text-3xl font-extrabold text-slate-900">Manage Cheat Sheets</h2>
                    <p class="text-slate-500 text-sm">
                        <c:choose>
                            <c:when test="${not empty selectedCategory}">
                                Currently reviewing: <span class="text-indigo-600 font-bold">${selectedCategory.name}</span> workspace.
                            </c:when>
                            <c:otherwise>Please select a category from the left panel to review items.</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </header>

            <c:choose>
                <c:when test="${empty selectedCatId}">
                    <div class="bg-white rounded-[2.5rem] p-20 text-center border border-slate-100 shadow-sm">
                        <div class="w-16 h-16 bg-indigo-50 text-indigo-600 rounded-3xl flex items-center justify-center mx-auto mb-4 text-xl">
                            <i class="fa-solid fa-arrow-left-long animate-pulse"></i>
                        </div>
                        <h3 class="text-base font-black text-slate-800">No Category Selected</h3>
                        <p class="text-slate-400 text-xs mt-1 max-w-xs mx-auto">Click any language or framework title from the left selection pane to pull active code cheatsheets.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden">
                        <div class="p-6 border-b border-slate-50 flex justify-between items-center bg-slate-50/50">
                            <span class="text-xs font-black text-slate-500 uppercase tracking-wider">All Workspace CheatSheets</span>
                            <span class="bg-indigo-50 text-indigo-700 text-[10px] font-black px-3 py-1 rounded-full uppercase tracking-wider">Total: ${cheatList.size()}</span>
                        </div>
                        
                        <div class="divide-y divide-slate-100">
                            <c:choose>
                                <c:when test="${empty cheatList}">
                                    <div class="p-16 text-center text-slate-400 font-bold text-xs">
                                        <i class="fa-solid fa-code text-3xl block mb-2 text-slate-200"></i> No code CheatSheets found in this category.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cheat" items="${cheatList}">
                                        <div class="p-8 hover:bg-slate-50/40 transition-all flex flex-col md:flex-row md:items-start justify-between gap-6">
                                            <div class="space-y-4 flex-1">
                                                
                                                <div class="flex flex-wrap items-center gap-3 text-[11px] font-semibold text-slate-400">
                                                    <span class="bg-indigo-50 text-indigo-600 font-black px-2.5 py-1 rounded-md text-[10px] uppercase">${cheat.categoryName}</span>
                                                    
                                                    <c:choose>
                                                        <c:when test="${cheat.status == 'APPROVED'}">
                                                            <span class="bg-emerald-50 text-emerald-600 font-bold px-2 py-0.5 rounded-md text-[10px] flex items-center gap-1">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> APPROVED (LIVE)
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="bg-rose-50 text-rose-600 font-bold px-2 py-0.5 rounded-md text-[10px] flex items-center gap-1">
                                                                <span class="w-1.5 h-1.5 rounded-full bg-rose-500"></span> BANNED (HIDDEN)
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                    <span>By <strong class="text-slate-600">@${cheat.userName}</strong></span>
                                                    <span class="text-slate-300">|</span>
                                                    <span><i class="fa-regular fa-calendar-plus mr-1"></i>Created: ${cheat.createdAt}</span>
                                                    <span class="text-slate-300">|</span>
                                                    <span><i class="fa-regular fa-pen-to-square mr-1"></i>Updated: ${cheat.updatedAt}</span>
                                                </div>
                                                
                                                <h4 class="text-lg font-extrabold text-slate-800 leading-tight">${cheat.title}</h4>
                                                
                                                <div class="bg-slate-900 rounded-2xl p-5 text-slate-200 text-xs font-mono max-h-48 overflow-y-auto shadow-inner whitespace-pre-wrap"><c:out value="${cheat.content}"/></div>
                                            </div>
                                            
                                            <div class="md:pt-1">
                                                <c:choose>
                                                    <c:when test="${cheat.status == 'APPROVED'}">
                                                        <a href="manage-cheats?action=ban&id=${cheat.id}&catId=${selectedCatId}" 
                                                           onclick="return confirm('Are you sure you want to BAN this cheat sheet? It will be taken down immediately.')"
                                                           class="w-full md:w-auto inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-rose-50 hover:bg-rose-600 text-rose-600 hover:text-white rounded-xl text-xs font-black shadow-sm transition-all border border-rose-100">
                                                            <i class="fa-solid fa-ban text-xs"></i> <span>Ban Cheatsheets</span>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="manage-cheats?action=approve&id=${cheat.id}&catId=${selectedCatId}" 
                                                           onclick="return confirm('Do you want to APPROVE this cheat sheet? It will be visible to users again.')"
                                                           class="w-full md:w-auto inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-emerald-50 hover:bg-emerald-600 text-emerald-600 hover:text-white rounded-xl text-xs font-black shadow-sm transition-all border border-emerald-100">
                                                            <i class="fa-solid fa-circle-check text-xs"></i> <span>Approve Cheatsheets</span>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
    </main>

</body>
</html>