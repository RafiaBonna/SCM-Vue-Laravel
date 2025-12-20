<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdminStock extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'opening_stock',
        'received_qty',
        'receive_return_qty',
        'sales_qty',
        'sales_return_qty',
        'wastage_qty',
        'current_stock',
    ];

    // প্রোডাক্টের সাথে সম্পর্ক
    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}