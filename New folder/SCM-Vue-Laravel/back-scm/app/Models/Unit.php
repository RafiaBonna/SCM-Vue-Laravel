<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Unit extends Model
{
    use HasFactory;

    // এই ফিল্ডগুলি ডেটাবেসে সেভ করার জন্য ব্যবহার হবে
    protected $fillable = [
        'name',
        'short_name',
    ];
}