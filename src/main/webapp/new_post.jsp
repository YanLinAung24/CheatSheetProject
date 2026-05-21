<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Post New Cheat | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; }
        .glass { background: rgba(255, 255, 255, 0.7); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.3); }
    </style>
</head>
<body>

    <!-- Top Nav (Same as Home) -->
    <nav class="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-[95%] lg:w-[90%] glass rounded-2xl px-6 py-3 flex items-center justify-between">
        <a href="user-home" class="text-2xl font-extrabold tracking-tight bg-gradient-to-r from-indigo-600 to-violet-600 bg-clip-text text-transparent">CheatSheet.</a>
        <div class="flex items-center gap-3">
             <span class="text-xs font-bold text-slate-500 italic">Creating New Post...</span>
             <div class="w-8 h-8 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-600"><i class="fa-solid fa-pen-nib text-xs"></i></div>
        </div>
    </nav>

    <div class="max-w-4xl mx-auto pt-32 pb-20 px-6">
        <header class="mb-10 flex items-center justify-between">
            <div>
                <h1 class="text-4xl font-extrabold text-slate-900 tracking-tight">Share Your Knowledge</h1>
                <p class="text-slate-500 mt-2">Fill in the details below to create a new premium cheat sheet.</p>
            </div>
            <a href="user-home" class="text-slate-400 hover:text-slate-900 transition-colors"><i class="fa-solid fa-xmark text-2xl"></i></a>
        </header>

        <form action="user-home" method="POST" enctype="multipart/form-data" class="space-y-8">
            <input type="hidden" name="action" value="add">

            <!-- Content Card -->
            <div class="bg-white rounded-[2.5rem] p-8 md:p-12 border border-slate-100 shadow-sm space-y-8">
                
                <!-- Title -->
                <div class="space-y-3">
                    <label class="text-[11px] font-black uppercase tracking-widest text-slate-400 ml-2">Cheat Title</label>
                    <input type="text" name="title" required placeholder="e.g. Docker Commands for Beginners"
                        class="w-full bg-slate-50 border-2 border-transparent focus:border-indigo-500/20 focus:bg-white rounded-2xl px-6 py-4 text-xl font-bold text-slate-800 outline-none transition-all">
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <!-- Category Selection -->
                    <div class="space-y-3">
                        <label class="text-[11px] font-black uppercase tracking-widest text-slate-400 ml-2">Select Category</label>
                        <div class="relative">
                            <select name="categoryId" class="w-full bg-slate-50 border-none rounded-2xl px-6 py-4 font-bold text-slate-600 outline-none appearance-none cursor-pointer focus:ring-2 focus:ring-indigo-500/10">
                                <c:forEach var="cat" items="${allCats}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                            <i class="fa-solid fa-chevron-down absolute right-6 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none text-xs"></i>
                        </div>
                    </div>

                    <!-- Multiple Tags Selection -->
                    <div class="space-y-3">
                        <label class="text-[11px] font-black uppercase tracking-widest text-slate-400 ml-2">Tags (Multiple)</label>
                        <select name="tagIds" multiple required class="w-full bg-slate-50 border-none rounded-2xl px-6 py-3 font-bold text-slate-500 outline-none h-32 scrollbar-hide focus:ring-2 focus:ring-indigo-500/10">
                            <c:forEach var="t" items="${allTags}">
                                <option value="${t.id}" class="py-2 px-2 rounded-lg mb-1 hover:bg-indigo-50"># ${t.tagName}</option>
                            </c:forEach>
                        </select>
                        <p class="text-[10px] text-slate-400 italic ml-2">Hold Ctrl (Cmd) to select more than one</p>
                    </div>
                </div>

                <!-- Content -->
                <div class="space-y-3">
                    <label class="text-[11px] font-black uppercase tracking-widest text-slate-400 ml-2">Content Details</label>
                    <textarea name="content" rows="10" required placeholder="Paste your syntax, codes or descriptions here..."
                        class="w-full bg-slate-50 border-none rounded-[2rem] px-8 py-6 text-slate-600 outline-none focus:ring-4 focus:ring-indigo-500/5 transition-all leading-relaxed"></textarea>
                </div>

                <!-- Photo Upload with Preview Area -->
               
            </div>

            <!-- Submit Section -->
            <div class="flex items-center justify-end gap-6">
                <a href="user-home" class="text-sm font-bold text-slate-400 hover:text-slate-600">Cancel</a>
                <button type="submit" class="bg-gradient-to-r from-indigo-600 to-violet-600 text-white px-10 py-5 rounded-2xl font-bold shadow-xl shadow-indigo-200 hover:scale-105 active:scale-95 transition-all uppercase tracking-widest text-sm">
                    Publish Cheat Sheet
                </button>
            </div>
        </form>
    </div>

    <script>
        function previewImage(input) {
            // Optional: Add logic to show selected filename or a preview thumbnail
        }
    </script>
</body>
</html>