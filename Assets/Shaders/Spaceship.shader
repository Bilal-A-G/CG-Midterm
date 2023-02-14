Shader "Custom/Spaceship"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalMap ("Normal (RGB)", 2D) = "white" {}
        _NormalStrength("Normal Strength", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _NormalMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_normalTex;
        };
        
        half _NormalStrength;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            float3 normal = UnpackNormal(tex2D(_NormalMap, IN.uv_normalTex));
            o.Normal = normal * float3(_NormalStrength, _NormalStrength, lerp(1/normal.b, normal.b, saturate(_NormalStrength)));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
