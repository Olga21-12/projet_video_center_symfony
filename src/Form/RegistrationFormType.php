<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\TextType;        // Добавил
use Symfony\Component\Form\Extension\Core\Type\EmailType;       // Добавил
use Symfony\Component\Form\Extension\Core\Type\FileType;        // Добавил
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\IsTrue;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\File;               // Добавил для File constraint
use Vich\UploaderBundle\Form\Type\VichImageType;

class RegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('firstname', TextType::class, [
                'label' => 'registrationForm.firstname'
            ])
            ->add('lastname', TextType::class, [
                'label' => 'registrationForm.lastname'
            ])
            ->add('email', EmailType::class, [
                'label' => 'registrationForm.email'
            ])
            ->add('agreeTerms', CheckboxType::class, [
                'mapped' => false,
                
                'label' => 'registrationForm.agreeTerms',
                'constraints' => [
                    new IsTrue([
                        //'message' => 'You should agree to our terms.',
                    ]),
                ],
            ])
            ->add('plainPassword', RepeatedType::class, [
                'type' => PasswordType::class,
                'first_options'  => [
                    'label' => 'registrationForm.plainPassword',
                    'attr' => ['autocomplete' => 'new-password']
                ],
                'second_options' => [
                    'label' => 'registrationForm.plainPassword2',
                    'attr' => ['autocomplete' => 'new-password']
                ],
                'invalid_message' => 'Les mots de passe ne correspondent pas.',
                'mapped' => false,
            ])

            ->add('imageFile', VichImageType::class, [
                'label' => 'registrationForm.photoDeProfil',
                'required' => false,
                'download_uri' => false,
                'image_uri' => false,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class,
        ]);
    }
}
