<?php

namespace App\Controller;

use App\Entity\Video;
use App\Form\VideoType;
use App\Repository\VideoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

use Symfony\Contracts\Translation\TranslatorInterface;

use DateTimeImmutable;
use App\Data\SearchData;
use App\Entity\Comment;
use App\Form\CommentType;
use App\Form\SearchType;
use Knp\Component\Pager\PaginatorInterface;


final class VideoController extends AbstractController
{

    #[Route('/new', name: 'app_video_new')]
    public function new(Request $request, EntityManagerInterface $entityManager, TranslatorInterface $translator): Response
    {
        if($this->getUser()){
            /**
            * @var User
            */
            $user = $this->getUser();

            if(!$user->isVerified()){
                $this->addFlash("info", "Vous devez confirmer votre adresse e-mail avant d'ajouter une vidéo.");
                return $this->redirectToRoute('app_profile');
            }
        }else{
            $this->addFlash("info", "Vous devez vous connecter pour créer une vidéo !");
            return $this->redirectToRoute("app_login");
        }

        $video = new Video;
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

     
    if($form->isSubmitted() && $form->isValid()){
        $video->setUser($this->getUser()); // для того чтобы пользователь мог создавать свои видео
        $video->setCreatedAt(new DateTimeImmutable());
        $video->setUpdatedAt(new DateTimeImmutable());

        $entityManager->persist($video);
        $entityManager->flush();

        $this->addFlash('success', 'Le vidéo '.$video->getTitle(). ' a bien été crée !');
            return $this->redirectToRoute('app_profile');
        }
        return $this->render('video/new.html.twig', [
            'monForm'=>$form
        ]);
    }  

    #[Route('/{id}', name: 'app_video_show')]
    public function show(Video $video, Request $request,
                        VideoRepository $videoRepository,
                        EntityManagerInterface $entityManager): Response
    {

        $video = $videoRepository->find($video->getId());
        return $this->render('video/show.html.twig', [
            'video' => $video,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_video_edit')]
    public function edit(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    {
        
        if($this->getUser()){
            /**
            * @var User
            */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash("error", "Vous devez confirmer votre email pour éditer une vidéo !");
                return $this->redirectToRoute('app_video_index');
            }
            if($user->getEmail() !== $video->getUser()->getEmail()){
                $this->addFlash("error", "Vous devez être ". $video->getUser()->getEmail() . " pour éditer cette vidéo !");
                return $this->redirectToRoute('app_video_index');
            }    
        }else{
            $this->addFlash("error", "Vous devez vous connecter pour éditer une vidéo !");
            return $this->redirectToRoute("app_login");
        }


        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if($form->isSubmitted() && $form->isValid()){  // для работы кнопки и замены данных в базе данных
                $video->setUpdatedAt(new DateTimeImmutable());
                $entityManager->flush();
                $this->addFlash('success','La vidéo a bien été modifiée'); //сообщение и успешном редактировании рецепта
              //  return $this->redirectToRoute('app_video_index'); // после редактирования переходит на страницу списка рецептов
                return $this->redirectToRoute('app_video_show', ['id' => $video->getId(),]); // после редактирования переходит на страницу рецепта
            } 

        return $this->render('video/edit.html.twig', [
            'video' => $video,
            'form' => $form,
        ]);
    }

    #[Route('/video/{id}/delete', name: 'app_video_delete')]
    public function delete(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    
    {
        if($this->getUser()){
            /**
            * @var User
            */
            $user = $this->getUser();
            if(!$user->isVerified()){
                $this->addFlash("error", "Vous devez confirmer votre email pour supprimer une vidéo !");
                return $this->redirectToRoute('app_profile');
            }
            if($user->getEmail() !== $video->getUser()->getEmail()){
                $this->addFlash("error", "Vous devez être ". $video->getUser()->getEmail() . " pour supprimer cette vidéo !");
                return $this->redirectToRoute('app_profile');
            } 
        }else{
            $this->addFlash("error", "Vous devez vous connecter pour supprimer une vidéo !");
            return $this->redirectToRoute("app_login");
        }    

        $title = $video->getTitle();

            $entityManager->remove($video);
            $entityManager->flush();

            $this->addFlash('info','La vidéo '.$title. ' a bien été supprimée !');
            return $this->redirectToRoute('app_profile');
        }
    }
