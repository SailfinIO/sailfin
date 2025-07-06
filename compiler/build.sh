p 3: Test real compiler
    test_real_compiler
    echo ""
    
    # Step 4: Build self-hosting
    build_self_hosting
    echo ""
    
    # Step 5: Test self-hosting
    test_self_hosting
    echo ""
    
    # Step 6: Create artifacts
    create_artifacts
    echo ""
    
    # Step 7: Summary
    print_summary
}

# Invoke main with all arguments
main "$@"

