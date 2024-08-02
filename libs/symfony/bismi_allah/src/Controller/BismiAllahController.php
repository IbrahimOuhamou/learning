<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class BismiAllahController {

    #[Route('/')]
    public function bismi_allah(): Response {
        return new Response('<h1>بسم الله الرحمن الرحيم</h1>');
    }
}
