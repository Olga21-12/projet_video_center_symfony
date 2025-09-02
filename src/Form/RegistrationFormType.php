<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\TextType;        
use Symfony\Component\Form\Extension\Core\Type\EmailType;       

use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\IsTrue;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;

use Vich\UploaderBundle\Form\Type\VichImageType;

class RegistrationFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('firstname', TextType::class, [
                'label' => 'registrationForm.firstname',
                'required' => false
            ])
            ->add('lastname', TextType::class, [
                'label' => 'registrationForm.lastname',
                'required' => false
            ])
            ->add('email', EmailType::class, [
                'label' => 'registrationForm.email',
                'required' => false
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
                    'attr' => ['autocomplete' => 'new-password'],
                    'constraints' => [
                    new NotBlank([
                        'message' => 'Please enter a password',
                    ]),
                    new Length([
                        'min' => 6,
                        'minMessage' => 'Your password should be at least {{ limit }} characters',
                        // max length allowed by Symfony for security reasons
                        'max' => 4096,
                    ]),
                ],
                    
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
                'allow_delete' => false, 
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
