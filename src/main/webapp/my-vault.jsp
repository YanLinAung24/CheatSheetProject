<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="mb-12">
    <h1 class="text-4xl font-[900] text-slate-900 tracking-tight mb-2">My Vault</h1>
    <p class="text-slate-500 font-medium italic">Cheat sheets created by you.</p>
</header>

<c:if test="${not empty userCheats}">
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
        <c:forEach var="cs" items="${userCheats}">
            <article class="cheat-card bg-white rounded-[2.5rem] overflow-hidden border border-slate-100 flex flex-col h-full shadow-sm">
                <div class="relative group h-32 bg-gradient-to-br from-slate-900 to-indigo-950 p-6 flex flex-col justify-between">
                    <div>
                        <span class="glass text-[10px] font-black uppercase tracking-widest text-indigo-400 px-4 py-2 rounded-full shadow-sm bg-white/10">
                            ${cs.categoryName}
                        </span>
                    </div>
                    
                    <div class="absolute top-5 right-5 flex items-center gap-2">
                        <a href="toggle-bookmark?id=${cs.id}" 
                           class="w-10 h-10 rounded-full flex items-center justify-center shadow-lg transition-all transform hover:scale-105
                                  ${cs.isBookmarked ? 'bg-amber-500 text-white' : 'bg-white/90 text-slate-400 hover:text-amber-500 md:opacity-0 md:group-hover:opacity-100'}" 
                           title="${cs.isBookmarked ? 'Remove Bookmark' : 'Bookmark Snippet'}">
                            <i class="fa-solid fa-bookmark text-sm"></i>
                        </a>

                        <a href="delete-post?id=${cs.id}" onclick="return confirm('Delete this snippet?')" 
                           class="w-10 h-10 rounded-full bg-white/90 text-rose-500 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow-lg">
                            <i class="fa-solid fa-trash-can text-sm"></i>
                        </a>
                    </div>
                </div>
                
                <div class="p-8 flex flex-col flex-1">
                    <h2 class="text-xl font-extrabold text-slate-800 mb-3 leading-tight hover:text-indigo-600">
                        <a href="view-edit?mode=view&id=${cs.id}&view=my">${cs.title}</a>
                    </h2>
                    
                    <div class="mb-5 flex-1">
                        <p class="text-slate-500 text-sm leading-relaxed line-clamp-3 font-medium">
                            ${cs.content}
                        </p>
                    </div>
                    
                    <div class="space-y-1.5 mb-6 pt-4 border-t border-slate-50 text-xs text-slate-400">
                        <div>
                            <i class="fa-regular fa-calendar"></i> 
                            <span class="font-medium text-slate-500">Created:</span> ${cs.createdAt}
                        </div>
                        <c:if test="${not empty cs.updatedAt}">
                            <div class="text-amber-600">
                                <i class="fa-solid fa-pen-to-square"></i> 
                                <span class="font-bold bg-amber-50 px-1.5 py-0.5 rounded text-[9px] uppercase">Edited</span> ${cs.updatedAt}
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="mt-auto pt-4 border-t border-slate-100 flex items-center justify-end gap-3">
                        <a href="view-edit?mode=edit&id=${cs.id}" class="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center text-slate-400 hover:text-indigo-600 border border-slate-100" title="Edit">
                            <i class="fa-solid fa-pen-nib text-sm"></i>
                        </a>
                        <a href="view-edit?mode=view&id=${cs.id}&view=my" class="w-10 h-10 rounded-xl bg-indigo-600 text-white flex items-center justify-center shadow-lg" title="View Full Screen">
                            <i class="fa-solid fa-arrow-up-right-from-square text-xs"></i>
                        </a>
                    </div>
                </div>
            </article>
        </c:forEach>
    </div>
</c:if>

<c:if test="${empty userCheats}">
    <div class="bg-white rounded-[3rem] py-20 border-2 border-dashed border-slate-100 flex flex-col items-center text-center p-6 shadow-sm">
        <h2 class="text-xl font-black text-slate-800">No personal snippets yet</h2>
        <a href="add-post" class="mt-6 bg-indigo-600 text-white px-6 py-3 rounded-xl font-bold shadow-md">Create First Post</a>
    </div>
</c:if>