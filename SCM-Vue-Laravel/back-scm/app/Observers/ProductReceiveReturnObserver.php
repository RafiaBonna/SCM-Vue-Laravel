<?php

namespace App\Observers;

use App\Models\ProductReceiveReturn;
use App\Models\AdminStock;

class ProductReceiveReturnObserver
{
    /**
     * Handle the ProductReceiveReturn "created" event.
     * যখনই নতুন রিটার্ন এন্ট্রি হবে, এটি অটোমেটিক রান হবে।
     */
    public function created(ProductReceiveReturn $productReceiveReturn)
    {
        // ঐ প্রোডাক্টের স্টক রেকর্ডটি খুঁজে বের করা
        $stock = AdminStock::where('product_id', $productReceiveReturn->product_id)->first();

        if ($stock) {
            // ১. রিটার্ন কলামে পরিমাণ যোগ করা
            $stock->receive_return_qty += $productReceiveReturn->quantity;

            // ২. বর্তমান মোট স্টক থেকে ওই পরিমাণ কমিয়ে দেওয়া
            $stock->current_stock -= $productReceiveReturn->quantity;

            // ৩. ডাটাবেসে সেভ করা
            $stock->save();
        }
    }

    /**
     * Handle the ProductReceiveReturn "updated" event. (Optional)
     */
    public function updated(ProductReceiveReturn $productReceiveReturn)
    {
        // ভবিষ্যতে এডিট করার লজিক লাগলে এখানে যোগ করা যাবে
    }

    /**
     * Handle the ProductReceiveReturn "deleted" event. (Optional)
     */
    public function deleted(ProductReceiveReturn $productReceiveReturn)
    {
        // ডিলিট করলে আবার স্টক বাড়িয়ে দেওয়ার লজিক এখানে হবে
    }
}