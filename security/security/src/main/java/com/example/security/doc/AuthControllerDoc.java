package com.example.security.doc;

import com.example.security.dto.request.LoginRequest;
import com.example.security.dto.request.RegisterUserRequest;
import com.example.security.dto.response.LoginResponse;
import com.example.security.dto.response.RegisterUserResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;


@Tag(
        name = "Auth",
        description = "Autenticação e cadastro de usuários"
)
public interface AuthControllerDoc {

    @Operation(
            summary = "Realiza o login",
            description = "Autentica com e-mail e senha e retorna um token JWT."
    )
    @ApiResponses({
            @ApiResponse(
                    responseCode = "200",
                    description = "Login realizado com sucesso",
                    content = @Content(
                            mediaType = "application/json",
                            schema = @Schema(
                                    implementation = LoginResponse.class
                            )
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Dados obrigatórios ausentes",
                    content = @Content
            )
    })
    ResponseEntity<LoginResponse> login(LoginRequest request);

    @Operation(
            summary = "Cadastra um usuário",
            description = "Cria um usuário com nome, e-mail e senha."
    )
    @ApiResponses({
            @ApiResponse(
                    responseCode = "201",
                    description = "Usuário cadastrado com sucesso",
                    content = @Content(
                            mediaType = "application/json",
                            schema = @Schema(
                                    implementation = RegisterUserResponse.class
                            )
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Dados obrigatórios ausentes",
                    content = @Content
            )
    })
    ResponseEntity<RegisterUserResponse> register(
            RegisterUserRequest request
    );
}