<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

// App\{dir_name}: php standards
namespace App\Controller;

use App\Repository\BismiAllahRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class BismiAllahController extends AbstractController {

    #[Route('/')]
    public function bismi_allah(BismiAllahRepository $bismi_allah_repository): Response {
        $bismi_allah_var = 99;
        $bismi_allah_asso_arr = $bismi_allah_repository->getId(rand(0, 400)) ?? throw $this->createNotFoundException('NOT FOUND bismi_allah.id < 0');

        // {controller_name}/{method_name}
        return $this->render('bismi_allah/bismi_allah.html.twig', [
            'bismi_allah_var' => $bismi_allah_var,
            'bismi_allah_asso_arr' => $bismi_allah_asso_arr,
        ]);
    }

    #[Route('/bismi_allah/{id}')]
    public function bismiAllahObject(BismiAllahRepository $bismi_allah_repository): Response {
        
    }
}
