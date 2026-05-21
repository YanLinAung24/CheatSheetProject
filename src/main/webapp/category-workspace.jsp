<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="mb-12">
    <div class="mb-2">
        <a href="user-home?view=explore" class="text-xs font-bold text-indigo-600 hover:underline">
            <i class="fa-solid fa-arrow-left"></i> Back to Categories
        </a>
    </div>
    <h1 class="text-4xl font-[900] text-slate-900 tracking-tight mb-2">${selectedCatName} Workspace</h1>
    <p class="text-slate-500 font-medium italic">All cheat sheets categorized under ${selectedCatName}.</p>
</header>

<c:if test="${not empty userCheats}">
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
        <c:forEach var="cs" items="${userCheats}">
            <article class="cheat-card bg-white rounded-[2.5rem] overflow-hidden border border-slate-100 flex flex-col h-full shadow-sm">
                
                <div class="relative group h-24 bg-gradient-to-br from-violet-900 to-indigo-950 p-6 flex flex-col justify-between">
                    <div>
                        <span class="glass text-[10px] font-black uppercase tracking-widest text-indigo-400 px-4 py-2 rounded-full shadow-sm bg-white/10">
                            ${cs.categoryName}
                        </span>
                    </div>
                    
                    <div class="absolute top-5 right-5">
                        <a href="toggle-bookmark?id=${cs.id}" 
                           class="w-10 h-10 rounded-full flex items-center justify-center shadow-lg transition-all transform hover:scale-105
                                  ${cs.isBookmarked ? 'bg-amber-500 text-white' : 'bg-white/90 text-slate-400 hover:text-amber-500 md:opacity-0 md:group-hover:opacity-100'}" 
                           title="${cs.isBookmarked ? 'Remove Bookmark' : 'Bookmark Snippet'}">
                            <i class="fa-solid fa-bookmark text-sm"></i>
                        </a>
                    </div>
                </div>
                
                <div class="p-8 flex flex-col flex-1">
                    <div class="flex items-center gap-2 mb-3 text-xs text-slate-400">
                        <div class="w-5 h-5 rounded-full bg-slate-100 flex items-center justify-center text-[10px] font-black text-slate-600 border border-slate-200">
                            <%-- Username ရဲ့ ရှေ့ဆုံးစာလုံးကို Avatar အဖြစ်ပြမယ် (မရှိရင် 'U') --%>
                            ${not empty cs.userName ? cs.userName.substring(0,1).toUpperCase() : 'U'}
                        </div>
                        <span class="font-bold text-slate-500">
                            by @${not empty cs.userName ? cs.userName : 'unknown'}
                        </span>
                    </div>

                    <h2 class="text-xl font-extrabold text-slate-800 mb-4 leading-tight hover:text-indigo-600">
                        <a href="view-edit?mode=view&id=${cs.id}&view=category&catId=${param.catId}">${cs.title}</a>
                    </h2>
                    
                    <div class="space-y-1 text-xs text-slate-400 mb-6">
                        <div>
                            <i class="fa-regular fa-calendar"></i> <span class="font-medium text-slate-500">Posted At:</span> ${cs.createdAt}
                        </div>
                        <c:if test="${not empty cs.updatedAt}">
                            <div class="text-amber-600">
                                <i class="fa-solid fa-pen-to-square"></i> <span class="font-bold bg-amber-50 px-1.5 py-0.5 rounded text-[9px] uppercase">Updated At:</span> ${cs.updatedAt}
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="mt-auto pt-4 border-t border-slate-50 flex justify-end">
                        <a href="view-edit?mode=view&id=${cs.id}&view=category&catId=${param.catId}" class="w-full bg-slate-900 text-white font-bold py-3 rounded-xl text-center text-xs hover:bg-indigo-600
transition-colors">View Snippet</a>
                    </div>
                </div>
            </article>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty userCheats}">
    <div class="bg-white rounded-[3rem] py-20 border-2 border-dashed border-slate-100 flex flex-col items-center text-center p-6 shadow-sm">
        <h2 class="text-xl font-black text-slate-800">No cheat sheets found in this category</h2>
        <a href="user-home?view=explore" class="mt-4 text-sm font-bold text-indigo-600 hover:underline">Back to Explore</a>
    </div>
</c:if>


