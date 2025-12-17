<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductReceive extends Model
{
    use HasFactory;

    protected $fillable = [
        'receive_number', 'receive_date', 'product_id', 
        'quantity', 'batch_no', 'note'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}