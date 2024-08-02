<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

// App\{dir_name}: php standards
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class BismiAllahController extends AbstractController {

    #[Route('/')]
    public function bismi_allah(): Response {
        $bismi_allah_var = 99;
        $bismi_allah_asso_arr = [
            'id' => 1,
            'name' => 'bismi_allah',
        ];

        // {controller_name}/{method_name}
        return $this->render('bismi_allah/bismi_allah.html.twig', [
            'bismi_allah_var' => $bismi_allah_var,
            'bismi_allah_asso_arr' => $bismi_allah_asso_arr,
        ]);
    }
}
