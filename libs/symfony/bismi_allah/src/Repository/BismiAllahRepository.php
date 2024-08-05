<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

namespace App\Repository;

use App\Model\BismiAllah;
use App\Model\BismiAllahStatusEnum;
use Psr\Log\LoggerInterface;

class BismiAllahRepository {
    public function __construct(private LoggerInterface $logger) {
    }

    public function findAll(): array {
        $this->logger->info('بسم الله الرحمن الرحيم');
        return [
            new BismiAllah(1, 'bismi_allah_1', BismiAllahStatusEnum::COMPLETED),
            new BismiAllah(2, 'bismi_allah_2', BismiAllahStatusEnum::COMPLETED),
            new BismiAllah(103, 'bismi_allah_103', BismiAllahStatusEnum::IN_PROGRESS),
            new BismiAllah(400, 'bismi_allah_400', BismiAllahStatusEnum::IN_PROGRESS),
        ];
    }

    public function getId(int $id): ?BismiAllah {
        if($id < 0) return null;
        return new BismiAllah($id, 'bismi_allah_' . $id, $id % 2 === 0 ? BismiAllahStatusEnum::COMPLETED : BismiAllahStatusEnum::IN_PROGRESS);
    }
}

