<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

namespace App\Controller;
use App\Repository\BismiAllahRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;


#[Route('/bismi_allah/')]
class BismiAllahController extends AbstractController {
    public function __construct(private BismiAllahRepository $bismi_allah_repository) {
    }

    #[Route('{id<\d+>}', name: 'app_bismi_allah_show_id')]
    public function showId(int $id): Response {
        $bismi_allah = $this->bismi_allah_repository->getId($id)
            ??
            throw $this->createNotFoundException('could not find BismiAllah object');
            ;

            return $this->render('bismi_allah/bismi_allah_show_id.html.twig', [
                'bismi_allah' => $bismi_allah,
            ]);
    }
}


