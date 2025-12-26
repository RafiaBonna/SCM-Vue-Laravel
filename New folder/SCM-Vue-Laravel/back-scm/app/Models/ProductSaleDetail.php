<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductSaleDetail extends Model
{
    use HasFactory;

    // Migration file-e table-er naam 'product_sales_details' (shesh-e s ache)
    // Tai Model-e oita nirdishto kore bole dite hobe
    protected $table = 'product_sales_details'; 

    protected $fillable = [
        'product_sale_id',
        'product_id',
        'quantity',
        'unit_price',
        'subtotal'
    ];

    public function sale()
    {
        return $this->belongsTo(ProductSale::class, 'product_sale_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}