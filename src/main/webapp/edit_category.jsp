<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit ${type == 'cat' ? 'Category' : 'Tag'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style> body { font-family: 'Plus Jakarta Sans', sans-serif; } </style>
</head>
<body class="bg-slate-50 flex items-center justify-center min-h-screen p-6">

    <div class="w-full max-w-md bg-white rounded-[3rem] p-10 shadow-2xl shadow-indigo-100 border border-white">
        <div class="text-center mb-10">
            <div class="w-16 h-16 bg-indigo-50 rounded-2xl flex items-center justify-center text-indigo-600 mx-auto mb-4">
                <i class="fa-solid fa-pen-nib text-xl"></i>
            </div>
            <h2 class="text-2xl font-black text-slate-800">Edit ${type == 'cat' ? 'Category' : 'Tag'}</h2>
            <p class="text-slate-400 text-sm mt-1">Update your information below</p>
        </div>

        <form action="manage-categories" method="POST" class="space-y-6">
            <!-- Hidden Fields -->
            <input type="hidden" name="action" value="${type == 'cat' ? 'updateCat' : 'updateTag'}">
            <input type="hidden" name="id" value="${editObj.id}">
            
            <div class="space-y-2">
                <label class="block text-[10px] font-black uppercase tracking-widest text-slate-400 ml-1">
                    Display Name
                </label>
                <input type="text" 
                       name="${type == 'cat' ? 'name' : 'tagName'}" 
                       value="${type == 'cat' ? editObj.name : editObj.tagName}" 
                       required
                       class="w-full bg-slate-50 border-none rounded-2xl px-6 py-4 text-sm font-bold text-slate-700 outline-none focus:ring-2 focus:ring-indigo-500/20 transition">
            </div>
            
            <div class="flex gap-4 pt-4">
                <a href="manage-categories" 
                   class="flex-1 text-center py-4 rounded-2xl bg-slate-100 text-slate-500 font-bold text-sm hover:bg-slate-200 transition">
                    Cancel
                </a>
                <button type="submit" 
                        class="flex-1 py-4 rounded-2xl bg-indigo-600 text-white font-bold text-sm shadow-lg shadow-indigo-200 hover:bg-indigo-700 transition">
                    Save Changes
                </button>
            </div>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>