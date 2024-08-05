<?php

namespace App\Model;
use App\Model\BismiAllahStatusEnum;

class BismiAllah {

    public function __construct(public int $id, public string $name, public BismiAllahStatusEnum $status) {
    }

    public function getStatusImageFileName(): string {
        return match ($this->status) {
            BismiAllahStatusEnum::COMPLETED => 'images/status-completed.png',
            BismiAllahStatusEnum::IN_PROGRESS => 'images/status-in-progress.png',
        };
    }
}

