<?php

namespace App\Observers;

use App\Models\ProductReceive;
use App\Models\AdminStock;

class ProductReceiveObserver
{
    public function created(ProductReceive $productReceive)
    {
        // ঐ প্রোডাক্টের জন্য স্টক রেকর্ডটি খুঁজে বের করা বা নতুন তৈরি করা
        $stock = AdminStock::firstOrCreate(
            ['product_id' => $productReceive->product_id],
            ['current_stock' => 0, 'received_qty' => 0]
        );

        // স্টক আপডেট করা
        $stock->received_qty += $productReceive->quantity;
        $stock->current_stock += $productReceive->quantity;
        $stock->save();
    }
}