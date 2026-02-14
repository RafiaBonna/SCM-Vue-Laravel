<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'sku', 'unit', 'mrp', 'retail_rate', 
        'distributor_rate', 'depo_rate', 'description', 'status'
    ];

    // Admin Stock-er sathe somporko (Step 2)
    public function adminStock()
    {
        return $this->hasOne(AdminStock::class);
    }

    public function receives()
    {
        return $this->hasMany(ProductReceive::class);
    }
}