<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

// App\{dir_name}: php standards
namespace App\Controller;

use App\Model\BismiAllah;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class ApiController extends AbstractController {
    #[Route('api/json')]
    public function getJson(): Response {
        $bismi_allah_data = [
            new BismiAllah(1, 'bismi_allah_1'),
            new BismiAllah(2, 'bismi_allah_2'),
            new BismiAllah(3, 'bismi_allah_3'),
            [
                'id' => 4,
                'name' => 'bismi_allah_3',
            ],
        ];

        return $this->json($bismi_allah_data);
    }
}
