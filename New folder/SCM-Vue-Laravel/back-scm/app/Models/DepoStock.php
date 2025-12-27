<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DepoStock extends Model
{
    use HasFactory;

    protected $fillable = [
        'depo_id', 'product_id', 'opening_stock', 'received_qty', 
        'receive_return_qty', 'sales_qty', 'sales_return_qty', 
        'wastage_qty', 'current_stock'
    ];

    public function product() {
        return $this->belongsTo(Product::class);
    }

    public function depo() {
        return $this->belongsTo(Depo::class);
    }
}