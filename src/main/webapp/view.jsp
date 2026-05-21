<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="max-w-[1000px] mx-auto pt-32 pb-20 px-6">
    
    <!-- Breadcrumb & Actions -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
        <div class="flex items-center gap-3">
            <a href="user-home" class="w-10 h-10 rounded-full bg-white border border-slate-100 flex items-center justify-center text-slate-400 hover:text-indigo-600 transition-all shadow-sm">
                <i class="fa-solid fa-arrow-left text-sm"></i>
            </a>
            <div class="flex items-center gap-2 text-[11px] font-black uppercase tracking-widest text-slate-400">
                <span>Collections</span>
                <i class="fa-solid fa-chevron-right text-[8px]"></i>
                <span class="text-indigo-600">${cheat.categoryName}</span>
            </div>
        </div>
        
        <!-- Action Buttons (Only for the owner of the post) -->
        <div class="flex items-center gap-3">
            <a href="edit-cheat?id=${cheat.id}" class="flex items-center gap-2 bg-white border border-slate-100 px-4 py-2 rounded-xl text-xs font-bold text-slate-600 hover:bg-slate-50 transition-all">
                <i class="fa-solid fa-pen-to-square"></i> Edit
            </a>
            <a href="delete-cheat?id=${cheat.id}" class="flex items-center gap-2 bg-rose-50 px-4 py-2 rounded-xl text-xs font-bold text-rose-500 hover:bg-rose-100 transition-all">
                <i class="fa-solid fa-trash"></i> Delete
            </a>
        </div>
    </div>

    <!-- Main Content Area -->
    <article class="space-y-10">
        
        <!-- Header Section -->
        <header class="space-y-6">
            <h1 class="text-4xl md:text-6xl font-extrabold text-slate-900 leading-[1.1] tracking-tight">
                ${cheat.title}
            </h1>
            
            <div class="flex flex-wrap items-center gap-4">
                <div class="flex items-center gap-2 bg-slate-900 text-white px-3 py-1.5 rounded-lg">
                    <div class="w-5 h-5 rounded-full bg-white/20 flex items-center justify-center text-[10px] font-bold">
                        ${cheat.username.substring(0,1).toUpperCase()}
                    </div>
                    <span class="text-[11px] font-bold uppercase tracking-wider">${cheat.username}</span>
                </div>
                
                <div class="h-4 w-[1px] bg-slate-200 hidden sm:block"></div>
                
                <div class="flex flex-wrap gap-2">
                    <c:forEach var="tagName" items="${cheat.tagNames}">
                        <span class="text-[11px] font-bold text-slate-400 bg-slate-50 px-3 py-1.5 rounded-lg border border-slate-100">
                            #${tagName}
                        </span>
                    </c:forEach>
                </div>
            </div>
        </header>

        <!-- Featured Image -->
        <div class="rounded-[3rem] overflow-hidden shadow-2xl shadow-indigo-500/10 border border-white">
            <img src="img/${cheat.photo}" class="w-full h-auto object-cover max-h-[500px]" alt="${cheat.title}">
        </div>

        <!-- Content Body -->
        <div class="bg-white rounded-[3rem] p-8 md:p-16 border border-slate-100 shadow-sm">
            <div class="prose prose-slate max-w-none">
                <!-- whitespace-pre-wrap makes sure code indentation and new lines are preserved -->
                <p class="text-slate-600 text-lg leading-[1.8] whitespace-pre-wrap font-medium">
                    ${cheat.content}
                </p>
            </div>
            
            <div class="mt-16 pt-8 border-t border-slate-50 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div class="flex items-center gap-2 text-slate-400">
                    <i class="fa-regular fa-clock"></i>
                    <span class="text-xs font-bold uppercase tracking-widest">Published on ${cheat.createdAt}</span>
                </div>
                
                <button onclick="window.print()" class="flex items-center gap-2 text-indigo-600 font-bold text-sm hover:underline">
                    <i class="fa-solid fa-print"></i> Print as PDF
                </button>
            </div>
        </div>
    </article>
</div>