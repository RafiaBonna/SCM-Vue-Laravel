<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Distributor extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 
        'phone', 
        'email', 
        'address', 
        'depo_id'
    ];

   
    public function depo()
    {
        return $this->belongsTo(Depo::class, 'depo_id');
    }
}