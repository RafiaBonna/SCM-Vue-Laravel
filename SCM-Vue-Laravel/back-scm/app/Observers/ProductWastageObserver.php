<?php

namespace App\Observers;

use App\Models\ProductWastage;
use App\Models\AdminStock;

class ProductWastageObserver
{
    public function created(ProductWastage $productWastage)
    {
        $stock = AdminStock::where('product_id', $productWastage->product_id)->first();

        if ($stock) {
            // Wastage কলাম বাড়ানো এবং বর্তমান স্টক কমানো
            $stock->wastage_qty += $productWastage->quantity;
            $stock->current_stock -= $productWastage->quantity;
            $stock->save();
        }
    }
}