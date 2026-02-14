<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurchaseOrder extends Model
{
    use HasFactory;

    protected $fillable = [
        'po_number',
        'supplier_id',
        'purchase_date',
        'total_amount',
        'discount',
        'note'
    ];

    // Supplier-er sathe relation
    public function supplier()
    {
        return $this->belongsTo(Supplier::class);
    }

    // Invoice items-er sathe relation
    public function items()
    {
        return $this->hasMany(PurchaseOrderItem::class);
    }
}