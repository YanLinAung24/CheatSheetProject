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
    <title>${param.mode == 'edit' ? 'Edit' : 'View'} | ${cheat.title}</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass { 
            background: rgba(255, 255, 255, 0.75); 
            backdrop-filter: blur(14px); 
            border: 1px solid rgba(255, 255, 255, 0.4); 
        }
        /* 🌟 User Home နှင့် တစ်ထပ်တည်းတူသော Active Link Gradient */
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
                    <a href="user-home?view=my" class="flex items-center gap-4 px-5 py-3.5 rounded-[1.25rem] font-bold transition-all text-slate-500 hover:bg-white hover:text-indigo-600 ${param.view == 'my' || (empty param.view && empty param.catId) ? 'active-link' : ''}">
                        <i class="fa-solid fa-folder-user text-base"></i><span>My Cheatsheets</span>
                    </a>
                    <a href="user-home?view=explore" class="flex items-center gap-4 px-5 py-3.5 rounded-[1.25rem] font-bold transition-all text-slate-500 hover:bg-white hover:text-indigo-600 ${param.view == 'explore' ? 'active-link' : ''}">
                        <i class="fa-solid fa-compass text-base"></i><span>Explore Home</span>
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
                           ${param.catId == cat.id || currentCatId == cat.id ? 'active-link' : ''}">
                            <span class="text-sm font-bold text-slate-600 group-hover:text-indigo-600 transition-colors">${cat.name}</span>
                            <i class="fa-solid fa-chevron-right text-[10px] text-slate-300 group-hover:translate-x-1 group-hover:text-indigo-600 transition-all"></i>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </aside>

        <main class="flex-1 pb-20">
            <div class="mb-6">
                <a href="user-home" class="inline-flex items-center gap-2 text-xs font-bold text-slate-400 hover:text-indigo-600 transition-colors group">
                    <i class="fa-solid fa-arrow-left transition-transform group-hover:-translate-x-1"></i>
                    <span>Back to Library</span>
                </a>
            </div>

            <form action="view-edit" method="POST" class="bg-white rounded-[2.5rem] p-8 sm:p-12 shadow-sm border border-slate-100 relative overflow-hidden">
                <input type="hidden" name="id" value="${cheat.id}">
                
                <div class="absolute top-0 left-0 right-0 h-[5px] bg-gradient-to-r from-indigo-500 to-purple-500"></div>
                
                <div class="mb-8 pb-6 border-b border-slate-50">
                    <span class="inline-flex items-center bg-indigo-50 text-indigo-600 px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-widest shadow-inner mb-4">
                        <i class="fa-solid fa-tag text-[9px] mr-1.5"></i>${cheat.categoryName}
                    </span>
                    
                    <c:choose>
                        <c:when test="${param.mode == 'edit'}">
                            <div class="mt-2">
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-[1.5px] mb-2">Update Title</label>
                                <input type="text" name="title" value="${cheat.title}" required 
                                    class="w-full text-2xl font-extrabold text-slate-800 bg-slate-50 border border-slate-100 rounded-2xl p-4 focus:outline-none focus:ring-4 focus:ring-indigo-500/10 focus:bg-white transition-all">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h1 class="text-3xl font-[900] text-slate-900 tracking-tight leading-tight mt-1">${cheat.title}</h1>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="mt-4 flex flex-wrap gap-5 text-xs text-slate-400 font-medium">
                        <div><i class="fa-regular fa-calendar mr-1.5 text-slate-300"></i>Created: <span class="text-slate-600">${cheat.createdAt}</span></div>
                        <c:if test="${not empty cheat.updatedAt}">
                            <div class="text-amber-600 font-semibold"><i class="fa-solid fa-pen-to-square mr-1.5"></i>Updated: ${cheat.updatedAt}</div>
                        </c:if>
                    </div>
                </div>

                <div class="mb-8">
                    <c:choose>
                        <c:when test="${param.mode == 'edit'}">
                            <label class="block text-[10px] font-black text-slate-400 uppercase tracking-[1.5px] mb-2">Edit Content Details</label>
                            <textarea name="content" rows="12" required 
                                class="w-full bg-slate-50 border border-slate-100 rounded-3xl p-6 text-sm font-medium text-slate-700 leading-relaxed focus:outline-none focus:ring-4 focus:ring-indigo-500/10 focus:bg-white transition-all resize-none shadow-inner">${cheat.content}</textarea>
                        </c:when>
                        <c:otherwise>
                            <div class="bg-slate-50 p-8 rounded-3xl border border-slate-100/50 min-h-[250px]">
                                <p class="whitespace-pre-wrap text-slate-700 leading-relaxed font-medium text-sm">${cheat.content}</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 pt-4 border-t border-slate-50">
                    <c:choose>
                        <c:when test="${param.mode == 'edit'}">
                            <button type="submit" 
                                class="flex-1 bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-600 hover:to-teal-700 text-white font-bold p-4 rounded-2xl text-sm shadow-md active:scale-[0.99] transition-all flex items-center justify-center gap-2 cursor-pointer">
                                <i class="fa-solid fa-floppy-disk text-xs"></i>
                                <span>SAVE CHANGES</span>
                            </button>
                            <a href="view-edit?mode=view&id=${cheat.id}" 
                                class="bg-slate-100 hover:bg-slate-200 text-slate-500 font-bold p-4 rounded-2xl text-sm transition-all px-10 text-center flex items-center justify-center">
                                CANCEL
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="view-edit?mode=edit&id=${cheat.id}" 
                                class="flex-1 bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-600 hover:to-orange-600 text-white font-bold p-4 rounded-2xl text-sm shadow-md active:scale-[0.99] transition-all flex items-center justify-center gap-2 text-center">
                                <i class="fa-solid fa-pen-to-square text-xs"></i>
                                <span>EDIT CHEAT SHEET</span>
                            </a>
                            <a href="user-home" 
                                class="bg-slate-100 hover:bg-slate-200 text-slate-500 font-bold p-4 rounded-2xl text-sm transition-all px-10 text-center flex items-center justify-center">
                                BACK
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
        </main>
    </div>

</body>
</html>