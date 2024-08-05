<?php

namespace App\Model;
use App\Model\BismiAllahStatusEnum;

class BismiAllah {

    public function __construct(public int $id, public string $name, public BismiAllahStatusEnum $status) {
    }
}

