<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;

    // ডাটাবেসে যে কলামগুলো সেভ করার অনুমতি থাকবে
    protected $fillable = [
        'name', 
        'phone', 
        'address', 
        'depo_id'
    ];

    /**
     * কাস্টমারটি কোন ডেপোর আন্ডারে তা পাওয়ার জন্য
     */
    public function depo()
    {
        return $this->belongsTo(Depo::class, 'depo_id');
    }
}