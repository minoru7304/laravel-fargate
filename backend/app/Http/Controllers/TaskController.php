<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Task;

class TaskController extends Controller
{
    public function index(Request $request)
    {
      $tasks = Task::all();

      return view('tasks.index', compact('tasks'));
    }
}
