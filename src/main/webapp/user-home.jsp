<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty userObj}">
    <c:redirect url="login" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | CheatSheet</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass { background: rgba(255, 255, 255, 0.75); backdrop-filter: blur(14px); border: 1px solid rgba(255, 255, 255, 0.4); }
        .cheat-card { transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); }
        .cheat-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px -12px rgba(99, 102, 241, 0.12); }
        /* Active Link: စာလုံးအဖြူနဲ့ Premium Gradient ဖြစ်စေရန် */
        .active-link { background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); color: white !important; }
        .active-link span, .active-link i { color: white !important; }
        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
    </style>
</head>
<body class="bg-[#f8fafc] text-slate-900">

    <nav class="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-[95%] lg:w-[90%] glass rounded-[2rem] px-8 py-3 flex items-center justify-between shadow-sm">
        <div class="flex items-center gap-10">
            <a href="user-home" class="text-2xl font-[800] tracking-tighter bg-gradient-to-r from-indigo-600 to-violet-600 bg-clip-text text-transparent">CheatSheet.</a>
        </div>
        <div class="flex items-center gap-6">
            <a href="add-post" class="hidden sm:flex items-center gap-2 bg-slate-900 hover:bg-black text-white px-6 py-3 rounded-2xl text-sm font-bold transition-all shadow-lg">
                <i class="fa-solid fa-plus"></i><span>Post New</span>
            </a>
            <div class="flex items-center gap-3 bg-white/80 p-1.5 pr-5 rounded-full border border-slate-100 shadow-sm">
                <div class="w-9 h-9 rounded-full bg-gradient-to-tr from-indigo-500 to-purple-500 flex items-center justify-center text-white text-xs font-black">${userObj.username.substring(0,1).toUpperCase()}</div>
                <p class="text-xs font-bold text-slate-700 hidden md:block">${userObj.username}</p>
                <a href="logout" class="ml-2 text-slate-300 hover:text-red-500"><i class="fa-solid fa-power-off text-sm"></i></a>
            </div>
        </div>
    </nav>

    <div class="flex max-w-[1440px] mx-auto pt-32 px-8 gap-10">
        
        <aside class="hidden lg:block w-64 sticky top-32 h-[calc(100vh-140px)] overflow-y-auto pr-2 pb-10 space-y-8">
            <div>
                <h3 class="text-[10px] font-black uppercase tracking-[2.5px] text-slate-400 mb-4 ml-4">Workspace</h3>
                <div class="space-y-1">
                    <a href="user-home?view=my" class="flex items-center gap-4 px-5 py-3.5 rounded-[1.25rem] font-bold transition-all text-slate-500 hover:bg-white hover:text-indigo-600 ${activeTab == 'my' ? 'active-link' : ''}">
                        <i class="fa-solid fa-folder-user text-base"></i><span>My Cheatsheets</span>
                    </a>
                    <a href="user-home?view=explore" class="flex items-center gap-4 px-5 py-3.5 rounded-[1.25rem] font-bold transition-all text-slate-500 hover:bg-white hover:text-indigo-600 ${activeTab == 'explore' ? 'active-link' : ''}">
                        <i class="fa-solid fa-compass text-base"></i><span> Home</span>
                    </a>
                    <a href="user-home?view=bookmarks" class="flex items-center gap-4 px-5 py-3.5 rounded-[1.25rem] font-bold transition-all text-slate-500 hover:bg-white hover:text-indigo-600 ${param.view == 'bookmarks' || activeTab == 'bookmarks' ? 'active-link' : ''}">
        <i class="fa-solid fa-bookmark text-base"></i><span>Bookmarks</span>
    </a>
                </div>
            </div>

            <div>
                <h3 class="text-[10px] font-black uppercase tracking-[2.5px] text-slate-400 mb-4 ml-4">Categories</h3>
                <div class="space-y-1 max-h-[40vh] overflow-y-auto pr-1">
                    <c:forEach var="cat" items="${categoryList}">
                        <a href="user-home?view=category&catId=${cat.id}" 
                           class="flex items-center justify-between px-5 py-3 rounded-xl hover:bg-white group transition-all 
                           ${activeTab == 'category' && (param.catId == cat.id || currentCatId == cat.id) ? 'active-link' : ''}">
                            <span class="text-sm font-bold text-slate-600 group-hover:text-indigo-600 transition-colors">${cat.name}</span>
                            <i class="fa-solid fa-chevron-right text-[10px] text-slate-300 group-hover:translate-x-1 group-hover:text-indigo-600 transition-all"></i>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </aside>

        <main class="flex-1 pb-20">
            <c:choose>
                <c:when test="${activeTab == 'my'}">
                    <jsp:include page="my-vault.jsp" />
                </c:when>
                <c:when test="${activeTab == 'explore'}">
                    <jsp:include page="explore-categories.jsp" />
                </c:when>
                <c:when test="${activeTab == 'category'}">
                    <jsp:include page="category-workspace.jsp" />
                </c:when>
                <c:when test="${activeTab == 'bookmarks'}">
         <jsp:include page="bookmarks-vault.jsp" /> </c:when>
            </c:choose>
        </main>
    </div>
</body>