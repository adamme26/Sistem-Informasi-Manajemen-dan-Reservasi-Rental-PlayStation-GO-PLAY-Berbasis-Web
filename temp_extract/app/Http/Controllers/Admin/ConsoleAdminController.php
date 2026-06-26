<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Console;
use Illuminate\Http\Request;

class ConsoleAdminController extends Controller
{
    public function index()
    {
        $consoles = Console::latest()->paginate(20);
        return view('admin.consoles.index', compact('consoles'));
    }

    public function create()
    {
        return view('admin.consoles.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'           => 'required|string|max:100',
            'type'           => 'required|in:PS4,PS5',
            'description'    => 'nullable|string',
            'price_per_hour' => 'required|numeric|min:1000',
            'status'         => 'required|in:available,maintenance,booked',
            'image'          => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('consoles', 'public');
        }

        Console::create($validated);

        return redirect()->route('admin.consoles.index')->with('success', 'Konsol berhasil ditambahkan.');
    }

    public function edit(Console $console)
    {
        return view('admin.consoles.edit', compact('console'));
    }

    public function update(Request $request, Console $console)
    {
        $validated = $request->validate([
            'name'           => 'required|string|max:100',
            'type'           => 'required|in:PS4,PS5',
            'description'    => 'nullable|string',
            'price_per_hour' => 'required|numeric|min:1000',
            'status'         => 'required|in:available,maintenance,booked',
            'image'          => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('consoles', 'public');
        }

        $console->update($validated);

        return redirect()->route('admin.consoles.index')->with('success', 'Konsol berhasil diperbarui.');
    }

    public function destroy(Console $console)
    {
        $console->delete();
        return back()->with('success', 'Konsol berhasil dihapus.');
    }
}
