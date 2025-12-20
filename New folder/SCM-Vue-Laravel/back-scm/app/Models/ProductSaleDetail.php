<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductSaleDetail extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_sale_id',
        'product_id',
        'quantity',
        'unit_price',
        'subtotal'
    ];

    /**
     * এই ডিটেইলটি কোন মূল চালানের অংশ
     */
    public function sale()
    {
        return $this->belongsTo(ProductSale::class, 'product_sale_id');
    }

    /**
     * এই রো-তে কোন প্রোডাক্টটি বিক্রি করা হয়েছে
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}