package com.crofle.livecrowdfunding.config;


import com.crofle.livecrowdfunding.domain.enums.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import jakarta.annotation.PostConstruct;
import java.security.Key;
import java.util.Base64;
import java.util.Date;

@Component
public class JwtUtil {
    @Value("${jwt.secret}")
    private String secretKey;

    private final long ACCESS_TOKEN_EXPIRE_TIME = 1000 * 60 * 30; // 30분
    private final long REFRESH_TOKEN_EXPIRE_TIME = 1000 * 60 * 60 * 24 * 7; // 7일
    private final long PASSWORD_RESET_TOKEN_EXPIRE_TIME = 1000 * 60 * 15; // 15분

    @PostConstruct
    protected void init() {
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    // 로그인용 액세스 토큰 생성
    public String createAccessToken(String email, Role role) {
        Claims claims = Jwts.claims().setSubject(email);
        claims.put("role", role);
        return createToken(claims, ACCESS_TOKEN_EXPIRE_TIME);
    }

    // 리프레시 토큰 생성
    public String createRefreshToken(String email, Role role) {
        Claims claims = Jwts.claims().setSubject(email);
        claims.put("role", role);
        return createToken(claims, REFRESH_TOKEN_EXPIRE_TIME);
    }

    // 비밀번호 재설정 토큰 생성
    public String createPasswordResetToken(String email) {
        Claims claims = Jwts.claims().setSubject(email);
        claims.put("type", "password_reset");
        return createToken(claims, PASSWORD_RESET_TOKEN_EXPIRE_TIME);
    }

    // 토큰 생성 공통 메소드
    private String createToken(Claims claims, long expireTime) {
        Date now = new Date();
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(new Date(System.currentTimeMillis() + expireTime))  // 현재 시간을 밀리초 단위로 정확하게 가져옴
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    // 토큰 검증
    public boolean validateToken(String token) {
        try {
            Jws<Claims> claims = Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token);
            return !claims.getBody().getExpiration().before(new Date());
        } catch (Exception e) {
            return false;
        }
    }

    // 토큰에서 이메일 추출
    public String getEmailFromToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }
    // 토큰에서 역할 추출
    public Role getRoleFromToken(String token) {
        return Role.valueOf(Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .get("role", String.class));
    }

    private Key getSigningKey() {
        byte[] keyBytes = Base64.getDecoder().decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }



    public String getSecretKey() {
        return secretKey;
    }
}