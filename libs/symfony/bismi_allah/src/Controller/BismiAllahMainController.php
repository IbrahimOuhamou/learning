<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

// App\{dir_name}: php standards
namespace App\Controller;

use App\Repository\BismiAllahRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class BismiAllahMainController extends AbstractController {

    #[Route('/')]
    public function bismi_allah(BismiAllahRepository $bismi_allah_repository): Response {
        $bismi_allah_var = rand(0, 100);
        $bismi_allah_arr = $bismi_allah_repository->findAll() ?? throw $this->createNotFoundException('could not find BismiAllah object');

        // {controller_name}/{method_name}
        return $this->render('bismi_allah_main/bismi_allah.html.twig', [
            'bismi_allah_var' => $bismi_allah_var,
            'bismi_allah_arr' => $bismi_allah_arr,
        ]);
    }
}
