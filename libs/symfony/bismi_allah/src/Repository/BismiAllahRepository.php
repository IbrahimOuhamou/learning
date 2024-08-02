<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

namespace App\Repository;

use App\Model\BismiAllah;
use Psr\Log\LoggerInterface;

class BismiAllahRepository {
    public function __construct(private LoggerInterface $logger) {
    }

    public function findAll(): array {
        $this->logger->info('بسم الله الرحمن الرحيم');
        return [
            new BismiAllah(1, 'bismi_allah_1'),
            new BismiAllah(2, 'bismi_allah_2'),
            new BismiAllah(103, 'bismi_allah_103'),
            new BismiAllah(400, 'bismi_allah_400'),
        ];
    }

    public function getId(int $id): BismiAllah {
        return new BismiAllah($id, 'bismi_allah_' . $id);
    }
}

