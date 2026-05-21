<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="space-y-8">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-3xl font-[900] text-slate-900 tracking-tight">Bookmarks Vault</h1>
            <p class="text-slate-400 font-medium text-xs mt-1">Your personally curated reference deck for quick access.</p>
        </div>
        
        <div class="bg-amber-50 border border-amber-100 text-amber-700 px-4 py-2 rounded-2xl text-xs font-bold flex items-center gap-2">
            <i class="fa-solid fa-star"></i>
            <span>Saved: ${not empty userCheats ? userCheats.size() : 0}</span>
        </div>
    </div>

    <c:choose>
        <%-- 🌟 Bookmark လုပ်ထားတာ မရှိသေးလျှင် ပြသမည့် သပ်ရပ်လှပသော Empty State --%>
        <c:when test="${empty userCheats}">
            <div class="flex flex-col items-center justify-center bg-white rounded-[2.5rem] p-16 border border-slate-100 shadow-sm text-center">
                <div class="w-20 h-20 bg-amber-50 text-amber-500 rounded-3xl flex items-center justify-center text-3xl mb-6 shadow-inner animate-pulse">
                    <i class="fa-solid fa-bookmark"></i>
                </div>
                <h3 class="text-lg font-black text-slate-800 mb-2">No bookmarks saved yet</h3>
                <p class="text-slate-400 font-medium text-xs max-w-sm leading-relaxed mb-6">
                    Browse through your own library or explore public snippets, then click the bookmark icon to pinning them here.
                </p>
                <a href="user-home?view=my" class="bg-slate-900 hover:bg-black text-white px-6 py-3 rounded-2xl text-xs font-bold transition-all shadow-md">
                    Go to My Vault
                </a>
            </div>
        </c:when>

        <%-- 🌟 Bookmark ရှိလျှင် ပုံစံတူ Grid စနစ်ဖြင့် ကတ်ပြားလေးများ ပတ်ပြခြင်း --%>
        <c:otherwise>
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                <c:forEach var="cheat" items="${userCheats}">
                    <div class="cheat-card bg-white rounded-[2rem] p-6 border border-slate-100 shadow-sm relative flex flex-col justify-between overflow-hidden">
                        
                        <div class="flex justify-between items-center mb-4">
                            <span class="bg-indigo-50 text-indigo-600 px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-wider">
                                ${cheat.categoryName}
                            </span>
                            
                            <a href="user-home?action=toggleBookmark&id=${cheat.id}" 
                               class="text-amber-500 hover:text-slate-300 transition-colors p-1.5 rounded-xl hover:bg-slate-50"
                               title="Remove Bookmark">
                                <i class="fa-solid fa-bookmark text-base"></i>
                            </a>
                        </div>

                        <div class="space-y-2 flex-1">
                            <h3 class="text-base font-extrabold text-slate-800 line-clamp-1 leading-snug">${cheat.title}</h3>
                            
                            <div class="bg-slate-50/80 p-4 rounded-2xl min-h-[100px] max-h-[120px] overflow-hidden border border-slate-100/50">
                                <p class="text-xs text-slate-500 font-medium whitespace-pre-wrap leading-relaxed line-clamp-4">${cheat.content}</p>
                            </div>
                        </div>

                        <div class="mt-5 pt-4 border-t border-slate-50 flex items-center justify-between">
                            <a href="view-edit?mode=view&id=${cheat.id}&view=bookmarks" 
                               class="text-xs font-black text-indigo-600 hover:text-indigo-700 transition flex items-center gap-1.5 group">
                                <span>View Snippet</span>
                                <i class="fa-solid fa-arrow-right text-[10px] transition-transform group-hover:translate-x-1"></i>
                            </a>
                        </div>
                        
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>