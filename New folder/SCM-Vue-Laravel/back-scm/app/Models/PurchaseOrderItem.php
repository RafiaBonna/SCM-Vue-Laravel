<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurchaseOrderItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'purchase_order_id',
        'raw_material_id',
        'batch_no',
        'quantity',
        'unit_price',
        'sub_total'
    ];

    // Raw Material-er sathe relation
    public function raw_material()
    {
        return $this->belongsTo(RawMaterial::class);
    }
}